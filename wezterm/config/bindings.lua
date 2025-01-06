-- 快捷键说明:
-- F1: 激活复制模式
-- F2: 激活命令面板
-- F3: 显示启动器
-- F4: 显示标签导航器
-- F11: 切换全屏模式
-- F12: 显示调试覆盖层
-- f: 搜索（不区分大小写）
-- CTRL+SHIFT+c: 复制到剪贴板
-- CTRL+SHIFT+v: 从剪贴板粘贴
-- SUPER+t: 打开新标签
-- SUPER_REV+t: 打开WSL:Ubuntu标签
-- SUPER_REV+w: 关闭当前标签（不确认）
-- SUPER+[: 激活上一个标签
-- SUPER+]: 激活下一个标签
-- SUPER_REV+[: 移动到上一个标签
-- SUPER_REV+]: 移动到下一个标签
-- SUPER+n: 打开新窗口
-- SUPER_REV+/: 垂直分割窗格
-- SUPER_REV+\: 水平分割窗格
-- SUPER_REV+-: 关闭当前窗格（确认）
-- SUPER_REV+z: 切换窗格缩放状态
-- SUPER+w: 关闭当前窗格（不确认）
-- SUPER_REV+k: 激活上方窗格
-- SUPER_REV+j: 激活下方窗格
-- SUPER_REV+h: 激活左侧窗格
-- SUPER_REV+l: 激活右侧窗格
-- SUPER_REV+UpArrow: 调整窗格大小（向上）
-- SUPER_REV+DownArrow: 调整窗格大小（向下）
-- SUPER_REV+LeftArrow: 调整窗格大小（向左）
-- SUPER_REV+RightArrow: 调整窗格大小（向右）
-- SUPER+UpArrow: 增大字体
-- SUPER+DownArrow: 减小字体
-- SUPER+r: 重置字体大小
-- LEADER+f: 激活字体调整键表
-- LEADER+p: 激活窗格调整键表
-- CTRL+SHIFT+R: 重命名标签

local wezterm = require("wezterm")
local platform = require("utils.platform")()
local act = wezterm.action

local mod = {}

if platform.is_mac then
  mod.SUPER = "SUPER"
  mod.SUPER_REV = "SUPER|CTRL"
elseif platform.is_win then
  mod.SUPER = "ALT" -- to not conflict with Windows key shortcuts
  mod.SUPER_REV = "ALT|CTRL"
end

local keys = {
  -- misc/useful --
  { key = "F1", mods = "NONE", action = "ActivateCopyMode" },
  { key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
  { key = "F3", mods = "NONE", action = act.ShowLauncher },
  { key = "F4", mods = "NONE", action = act.ShowTabNavigator },
  { key = "F11", mods = "NONE", action = act.ToggleFullScreen },
  { key = "F12", mods = "NONE", action = act.ShowDebugOverlay },
  { key = "f", mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = "" }) },

  -- copy/paste --
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

  -- tabs --
  -- tabs: spawn+close
  { key = "t", mods = mod.SUPER, action = act.SpawnTab("DefaultDomain") },
  { key = "t", mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = "WSL:Ubuntu" }) },
  { key = "w", mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

  -- tabs: navigation
  { key = "[", mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
  { key = "]", mods = mod.SUPER, action = act.ActivateTabRelative(1) },
  { key = "[", mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  { key = "]", mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

  -- window --
  -- spawn windows
  { key = "n", mods = mod.SUPER, action = act.SpawnWindow },

  -- panes --
  -- panes: split panes
  {
    key = [[/]],
    mods = mod.SUPER_REV,
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = [[\]],
    mods = mod.SUPER_REV,
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = [[-]],
    mods = mod.SUPER_REV,
    action = act.CloseCurrentPane({ confirm = true }),
  },

  -- panes: zoom+close pane
  { key = "z", mods = mod.SUPER_REV, action = act.TogglePaneZoomState },
  { key = "w", mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

  -- panes: navigation
  { key = "k", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Right") },

  -- panes: resize
  { key = "UpArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Up", 1 }) },
  { key = "DownArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Down", 1 }) },
  { key = "LeftArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Left", 1 }) },
  { key = "RightArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({ "Right", 1 }) },

  -- fonts --
  -- fonts: resize
  { key = "UpArrow", mods = mod.SUPER, action = act.IncreaseFontSize },
  { key = "DownArrow", mods = mod.SUPER, action = act.DecreaseFontSize },
  { key = "r", mods = mod.SUPER, action = act.ResetFontSize },

  -- key-tables --
  -- resizes fonts
  {
    key = "f",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_font",
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
  -- resize panes
  {
    key = "p",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
  -- rename tab bar
  {
    key = "R",
    mods = "CTRL|SHIFT",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  -- new key binding
  {
    key = 'm',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ShowLauncher,
  },
}

local key_tables = {
  resize_font = {
    { key = "k", action = act.IncreaseFontSize },
    { key = "j", action = act.DecreaseFontSize },
    { key = "r", action = act.ResetFontSize },
    { key = "Escape", action = "PopKeyTable" },
    { key = "q", action = "PopKeyTable" },
  },
  resize_pane = {
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "q", action = "PopKeyTable" },
  },
}

local mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  -- Move mouse will only select text and not copy text to clipboard
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.SelectTextAtMouseCursor("Cell"),
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.ExtendSelectionToMouseCursor("Cell"),
  },
  {
    event = { Drag = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.ExtendSelectionToMouseCursor("Cell"),
  },
  -- Triple Left click will select a line
  {
    event = { Down = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = act.SelectTextAtMouseCursor("Line"),
  },
  {
    event = { Up = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = act.SelectTextAtMouseCursor("Line"),
  },
  -- Double Left click will select a word
  {
    event = { Down = { streak = 2, button = "Left" } },
    mods = "NONE",
    action = act.SelectTextAtMouseCursor("Word"),
  },
  {
    event = { Up = { streak = 2, button = "Left" } },
    mods = "NONE",
    action = act.SelectTextAtMouseCursor("Word"),
  },
  -- Turn on the mouse wheel to scroll the screen
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = "NONE",
    action = act.ScrollByCurrentEventWheelDelta,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = "NONE",
    action = act.ScrollByCurrentEventWheelDelta,
  },
}

return {
  disable_default_key_bindings = true,
  disable_default_mouse_bindings = true,
  leader = { key = "Space", mods = "CTRL|SHIFT" },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}