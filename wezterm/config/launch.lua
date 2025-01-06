local wezterm = require 'wezterm'

local platform = require("utils.platform")()

local options = {
  default_prog = {},
  launch_menu = {},
  keys = {},
}

if platform.is_win then
  options.default_prog = { "powershell" }
  options.launch_menu = {
    { label = " PowerShell v1", args = { "powershell" } },
    { label = " PowerShell v7", args = { "pwsh" } },
    { label = " Cmd", args = { "cmd" } },
    { label = " Nushell", args = { "nu" } },
    {
      label = " GitBash",
      args = { "C:\\soft\\Git\\bin\\bash.exe" },
    },
    {
      label = " a6",
      args = { "ssh", "root@172.24.199.104", "-p", "6002", "-i", "C:\\Users\\杨刚成\\.ssh\\id_rsa" },
    },
    {
      label = " a8-root",
      args = { "ssh", "root@172.24.225.115", "-p", "6002", "-i", "C:\\Users\\杨刚成\\.ssh\\id_rsa" },
    }
  }
elseif platform.is_mac then
  options.default_prog = { "/opt/ homebrew/bin/fish" }
  options.launch_menu = {
    { label = " Bash", args = { "bash" } },
    { label = " Fish", args = { "/opt/homebrew/bin/fish" } },
    { label = " Nushell", args = { "/opt/homebrew/bin/nu" } },
    { label = " Zsh", args = { "zsh" } },
  }
end



return options