local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.enable_wayland = false

config.term = "wezterm"

-- Cursor style
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBlock"

config.scrollback_lines = 10000
config.check_for_updates = false

-- Disable font ligatures to prevent != from rendering as ≠, etc
config.harfbuzz_features = { 'calt=0', 'liga=0' }

-- Fonts
-- config.font = wezterm.font('JetBrainsMono Nerd Font Mono')
config.font = wezterm.font_with_fallback({
  { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
  { family = 'Symbols Nerd Font' }, -- The absolute fallback for all icons
  -- for CJK characters, fallback to a font that supports them
  { family = 'Noto Sans Mono CJK SC', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK HK', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK JP', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK KR', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK TC', weight = 'Regular' },
})
-- change padding to 0 to make it more compact
config.window_padding = {
  left   = 0,
  right  = 0,
  top    = 0,
  bottom = 0,
}
config.warn_about_missing_glyphs = false
config.font_size   = 12.0
config.cell_width  = 0.88
config.line_height = 0.9
config.freetype_load_target   = 'Light'
config.freetype_render_target = 'HorizontalLcd'

-- Tab bar
config.enable_tab_bar = false

-- Shell
config.default_prog = { '/usr/bin/zsh', '-l' }

-- Colors
config.colors = {
  foreground = '#000000',
  background = '#ededcc',
  cursor_bg = '#000000',
  cursor_fg = '#ededcc',
  selection_bg = '#ecf024',
  selection_fg = '#000000',
  
  ansi = {
    '#696c77', -- black
    '#e45649', -- red
    '#50a14f', -- green
    '#c18401', -- yellow
    '#199aa6', -- blue
    '#a626a4', -- magenta
    '#0184bc', -- cyan
    '#a0a1a7', -- white
  },
  brights = {
    '#696c77',
    '#e45649',
    '#50a14f',
    '#c18401',
    '#199aa6',
    '#a626a4',
    '#0184bc',
    '#a0a1a7',
  },
  
  -- Search/Copy Mode Highlights matching focused_match and matches
  copy_mode_active_highlight_bg = { Color = '#000000' },
  copy_mode_active_highlight_fg = { Color = '#ededcc' },
  copy_mode_inactive_highlight_bg = { Color = '#ecf024' },
  copy_mode_inactive_highlight_fg = { Color = '#000000' },
}

-- Replicates the st terminal flow: extract all URLs from the scrollback with
-- xurls, list them in dmenu, and copy the one you pick. wezterm force-wraps
-- long URLs into physical rows, so we pull the scrollback via
-- get_text_from_region, which returns it UNWRAPPED (width-independent); xurls
-- then sees each URL as one contiguous line. run_child_process inherits DISPLAY
-- so dmenu renders on X11.
local function find_url_near_cursor(window, pane)
  local dims = pane:get_dimensions()
  local top = dims.scrollback_top
  local region = pane:get_text_from_region(
    0, top,
    dims.cols - 1, top + dims.scrollback_rows - 1
  )
  if not region or #region == 0 then
    window:toast_notification('wezterm', 'No scrollback to scan', nil, 2000)
    return
  end

  local tmp = '/tmp/opencode/wez_url_in.txt'
  local tf = io.open(tmp, 'w')
  if not tf then
    window:toast_notification('wezterm', 'Cannot write temp file', nil, 2000)
    return
  end
  tf:write(region)
  tf:close()

  -- stdout is the chosen dmenu line (with trailing newline); empty => cancelled.
  local success, stdout = wezterm.run_child_process {
    '/bin/sh', '-c',
    string.format("xurls '%s' | sort -u | dmenu -i -p 'Copy which url?' -l 10", tmp),
  }
  os.remove(tmp)

  if not success or not stdout or #stdout == 0 then
    -- dmenu cancelled or no URLs: nothing to do.
    return
  end

  local url = stdout:match('[^\n]*')
  if #url == 0 then return end
  window:copy_to_clipboard(url)
  window:toast_notification('wezterm', 'Copied (' .. #url .. ' chars)', nil, 2000)
end

-- Strip insignificant whitespace while preserving string contents, so a
-- pretty-printed (multi-line) value collapses to one dmenu row. JSON allows
-- removing ALL whitespace outside of string literals.
local function minify_json(s)
  local out = {}
  local in_string = false
  local escape_next = false
  local n = #s
  for i = 1, n do
    local c = s:sub(i, i)
    if escape_next then
      escape_next = false
      out[#out + 1] = c
    elseif c == '\\' and in_string then
      escape_next = true
      out[#out + 1] = c
    elseif c == '"' then
      in_string = not in_string
      out[#out + 1] = c
    elseif in_string then
      out[#out + 1] = c
    elseif not c:match('%s') then
      out[#out + 1] = c
    end
  end
  return table.concat(out)
end

-- Same flow as the URL extractor: pull the UNWRAPPED scrollback via
-- get_text_from_region (force-wrap-safe), collect every complete top-level
-- JSON value, list them in dmenu, and copy the one you pick.
local function extract_json_from_pane(window, pane)
  local dims = pane:get_dimensions()
  local top = dims.scrollback_top
  local region = pane:get_text_from_region(
    0, top,
    dims.cols - 1, top + dims.scrollback_rows - 1
  )
  if not region or #region == 0 then
    window:toast_notification('wezterm', 'No scrollback to scan', nil, 2000)
    return
  end

  -- Collect every complete top-level {..} or [..] value, respecting strings.
  local values = {}
  local n = #region
  local i = 1
  while i <= n do
    local char = region:sub(i, i)
    if char == '{' or char == '[' then
      local end_char = char == '{' and '}' or ']'
      local depth = 0
      local in_string = false
      local escape_next = false
      local j = i
      while j <= n do
        local c = region:sub(j, j)
        if escape_next then
          escape_next = false
        elseif c == '\\' and in_string then
          escape_next = true
        elseif c == '"' then
          in_string = not in_string
        elseif not in_string then
          if char == '{' and c == '{' or char == '[' and c == '[' then
            depth = depth + 1
          elseif c == end_char then
            depth = depth - 1
            if depth == 0 then
              values[#values + 1] = region:sub(i, j)
              i = j + 1
              break
            end
          end
        end
        j = j + 1
      end
      if j > n then break end
    else
      i = i + 1
    end
  end

  if #values == 0 then
    window:toast_notification('wezterm', 'No JSON found in scrollback', nil, 2000)
    return
  end

  -- Feed the candidates to dmenu; stdout is the chosen value (trailing newline).
  local tmp = '/tmp/opencode/wez_json_in.txt'
  local tf = io.open(tmp, 'w')
  if not tf then
    window:toast_notification('wezterm', 'Cannot write temp file', nil, 2000)
    return
  end
  for k, v in ipairs(values) do
    values[k] = minify_json(v)
  end
  -- Drop duplicates (stable: keep first occurrence).
  local seen, uniq = {}, {}
  for _, v in ipairs(values) do
    if not seen[v] then
      seen[v] = true
      uniq[#uniq + 1] = v
    end
  end
  tf:write(table.concat(uniq, '\n') .. '\n')
  tf:close()

  local success, stdout = wezterm.run_child_process {
    '/bin/sh', '-c',
    string.format("dmenu -i -p 'Copy which json?' -l 10 < '%s'", tmp),
  }
  os.remove(tmp)

  if not success or not stdout or #stdout == 0 then
    return
  end

  local json = stdout:match('[^\n]*')
  if #json == 0 then return end
  window:copy_to_clipboard(json)
  window:toast_notification('wezterm', 'Copied JSON (' .. #json .. ' chars)', nil, 2000)
end

-- Keybindings
config.keys = {
  -- Spawn new instance: Ctrl+Alt+Return -> Spawn new window
  {
    key = 'Return',
    mods = 'CTRL|ALT',
    action = wezterm.action.SpawnCommandInNewWindow {},
  },
  -- Paste: Ctrl+Alt+v
  {
    key = 'v',
    mods = 'CTRL|ALT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  -- Copy: Ctrl+Alt+c
  {
    key = 'c',
    mods = 'CTRL|ALT',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  -- Open native QuickSelect overlay: Ctrl+Alt+S
  {
    key = 's',
    mods = 'CTRL|ALT',
    action = wezterm.action.QuickSelect,
  },
  -- Disable default Ctrl+Shift+C / Ctrl+Shift+V
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'k',
    mods = 'SUPER',
    action = wezterm.action.ScrollToPrompt(-1),
  },
  {
    key = 'j',
    mods = 'SUPER',
    action = wezterm.action.ScrollToPrompt(1),
  },
  {
    key = 'j',
    mods = 'CTRL|ALT',
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = 'h',
    mods = 'CTRL|ALT',
    action = wezterm.action.ResetFontSize,
  },
  -- Toggle Copy Mode (Vi Mode): Ctrl+Alt+U
  {
    key = 'u',
    mods = 'CTRL|ALT',
    action = wezterm.action.ActivateCopyMode,
  },
  -- Send control characters
  {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.SendString '\x1b[27;5;9~',
  },
  {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SendString '\x1b[27;6;9~',
  },
  -- Shift+Enter workaround
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SendString '\x1b\r',
  },
  -- Copy wrapped/long URL from scrollback: Ctrl+Alt+O
  {
    key = 'o',
    mods = 'CTRL|ALT',
    action = wezterm.action_callback(find_url_near_cursor),
  },
  -- JSON Copy: Ctrl+Shift+J
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(extract_json_from_pane),
  },
}

config.key_tables = wezterm.gui.default_key_tables()

table.insert(config.key_tables.copy_mode, {
  key = '/',
  mods = 'NONE',
  action = wezterm.action.Multiple {
    wezterm.action.CopyMode 'ClearPattern',
    wezterm.action.CopyMode 'EditPattern',
  },
})

table.insert(config.key_tables.search_mode, {
  key = 'Enter',
  mods = 'NONE',
  action = wezterm.action.CopyMode 'AcceptPattern',
})

table.insert(config.key_tables.copy_mode, {
  key = 'n',
  mods = 'NONE',
  action = wezterm.action.CopyMode 'NextMatch',
})
table.insert(config.key_tables.copy_mode, {
  key = 'N',
  mods = 'SHIFT',
  action = wezterm.action.CopyMode 'PriorMatch',
})

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.SelectTextAtMouseCursor 'Block',
  },
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.ExtendSelectionToMouseCursor 'Block',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
}

local act = wezterm.action
config.key_tables = config.key_tables or {}
config.key_tables.copy_mode = config.key_tables.copy_mode or {}
table.insert(config.key_tables.copy_mode, {
  key = '%', mods = 'NONE', action = act.CopyMode 'JumpToMatchingBracket',
})

return config
