local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Enable native Wayland support for user `mango`
config.enable_wayland = true

config.term = "wezterm"

-- Cursor style
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBlock"

config.scrollback_lines = 10000
config.check_for_updates = false

-- Disable font ligatures
config.harfbuzz_features = { 'calt=0', 'liga=0' }

-- Fonts
config.font = wezterm.font_with_fallback({
  { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
  { family = 'Symbols Nerd Font' },
  { family = 'Noto Sans Mono CJK SC', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK HK', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK JP', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK KR', weight = 'Regular' },
  { family = 'Noto Sans Mono CJK TC', weight = 'Regular' },
})

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

config.color_schemes = {
  ['Custom'] = {
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

    copy_mode_active_highlight_bg = { Color = '#000000' },
    copy_mode_active_highlight_fg = { Color = '#ededcc' },
    copy_mode_inactive_highlight_bg = { Color = '#ecf024' },
    copy_mode_inactive_highlight_fg = { Color = '#000000' },
  },
}
config.color_scheme = 'Custom'

-- Wayland-friendly URL Extraction via rofi -dmenu
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

  local tmp = '/tmp/wez_url_in.txt'
  local tf = io.open(tmp, 'w')
  if not tf then
    window:toast_notification('wezterm', 'Cannot write temp file', nil, 2000)
    return
  end
  tf:write(region)
  tf:close()

  local success, stdout = wezterm.run_child_process {
    '/bin/sh', '-c',
    string.format("xurls -r '%s' | sort -u | rofi -dmenu -p 'Copy URL'", tmp),
  }
  os.remove(tmp)

  if not success or not stdout or #stdout == 0 then
    return
  end

  local url = stdout:match('[^\n]*')
  if #url == 0 then return end
  window:copy_to_clipboard(url)
  window:toast_notification('wezterm', 'Copied (' .. #url .. ' chars)', nil, 2000)
end

-- Keybindings
config.keys = {
  {
    key = 'Return',
    mods = 'CTRL|ALT',
    action = wezterm.action.SpawnCommandInNewWindow {},
  },
  {
    key = 'v',
    mods = 'CTRL|ALT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  {
    key = 'c',
    mods = 'CTRL|ALT',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  {
    key = 's',
    mods = 'CTRL|ALT',
    action = wezterm.action.QuickSelect,
  },
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
    key = 'Space',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'Space',
    mods = 'CTRL',
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
  {
    key = 'u',
    mods = 'CTRL|ALT',
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = 'o',
    mods = 'CTRL|ALT',
    action = wezterm.action_callback(find_url_near_cursor),
  },
}

config.key_tables = wezterm.gui.default_key_tables()

return config
