local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.term = "wezterm"
config.enable_wayland = false

-- Cursor style
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBlock"

config.scrollback_lines = 10000

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
  local i = #text
  
  while i >= 1 do
    local char = text:sub(i, i)
    
    if char == '}' or char == ']' then
      local json_end = i
      local brace_count = 0
      local in_string = false
      local escape_next = false
      local end_char = char
      local start_char = char == '}' and '{' or '['
      
      while i >= 1 do
        char = text:sub(i, i)
        
        if escape_next then
          escape_next = false
        elseif char == '\\' and in_string then
          escape_next = true
        elseif char == '"' then
          in_string = not in_string
        elseif not in_string then
          if char == end_char then
            brace_count = brace_count + 1
          elseif char == start_char then
            brace_count = brace_count - 1
            if brace_count == 0 then
              local json_str = text:sub(i, json_end)
              window:copy_to_clipboard(json_str, 'Clipboard')
              return
            end
          end
        end
        i = i - 1
      end
    end
    i = i - 1
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
  -- Unbind the default Quick Select shortcut
  {
    key = 'Space',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
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
  -- Execute alacritty-invert-colours script in the background: Ctrl+Alt+I
  {
    key = 'i',
    mods = 'CTRL|ALT',
    action = wezterm.action_callback(function(window, pane)
      wezterm.background_child_process { 'alacritty-invert-colours' }
    end),
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
  -- Select and copy JSON: Ctrl+Shift+J
  -- {
  --   key = 'j',
  --   mods = 'CTRL|SHIFT',
  --   action = wezterm.action.QuickSelectArgs {
  --     patterns = { '\\{[^}]*\\}|\\[[^\\]]*\\]' },
  --     action = wezterm.action.CopyTo 'Clipboard',
  --   },
  -- },
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

return config
