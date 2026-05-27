local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.term = "wezterm"

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
config.font_size   = 11.0
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
    key = ' ',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
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
}

return config
