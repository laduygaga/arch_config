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

local function extract_json_from_pane(window, pane)
  local text = pane:get_lines_as_text(10000)
  -- Copy the last complete top-level JSON value (nested fragments are skipped).
  local last_json = nil
  local i = 1
  local n = #text
  while i <= n do
    local char = text:sub(i, i)
    if char == '{' or char == '[' then
      local end_char = char == '{' and '}' or ']'
      local depth = 0
      local in_string = false
      local escape_next = false
      local j = i
      while j <= n do
        local c = text:sub(j, j)
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
              last_json = text:sub(i, j)
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

  if last_json then
    window:copy_to_clipboard(last_json, 'Clipboard')
    window:toast_notification('wezterm', 'Copied JSON to clipboard', nil, 2000)
  else
    window:toast_notification('wezterm', 'No JSON found in scrollback', nil, 2000)
  end
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
  -- Scroll half page up: Super+K
  {
    key = 'k',
    mods = 'SUPER',
    action = wezterm.action.ScrollByPage(-0.5),
  },
  -- Scroll half page down: Super+J
  {
    key = 'j',
    mods = 'SUPER',
    action = wezterm.action.ScrollByPage(0.5),
  },
  -- Decrease font size: Ctrl+Alt+J
  {
    key = 'j',
    mods = 'CTRL|ALT',
    action = wezterm.action.DecreaseFontSize,
  },
  -- Increase font size: Ctrl+Alt+K
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = wezterm.action.IncreaseFontSize,
  },
  -- Reset font size: Ctrl+Alt+H
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
  -- Open URL under cursor: Ctrl+Alt+O
  {
    key = 'o',
    mods = 'CTRL|ALT',
    action = wezterm.action.QuickSelectArgs {
      patterns = { 
        'https?://[^\\s\\)\\]]+', -- Matches web URLs excluding trailing ) or ]
        'file://[^\\s\\)\\]]+'    -- Matches file paths excluding trailing ) or ]
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        -- wezterm.open_with(url)
        window:copy_to_clipboard(url)
      end),
    },
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

return config
