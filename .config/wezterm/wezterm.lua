local k = require("utils/keys")

local io = require 'io';
local os = require 'os';
local wezterm = require 'wezterm';
local act = wezterm.action

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
  -- Retrieve the current viewport's text.
  -- Pass an optional number of lines (eg: 2000) to retrieve
  -- that number of lines starting from the bottom of the viewport
  local scrollback = pane:get_lines_as_text(3500);

  -- Create a temporary file to pass to vim
  local name = os.tmpname();
  local f = io.open(name, "w+");
  f:write(scrollback);
  f:flush();
  f:close();

  -- Open a new window running vim and tell it to open the file
  window:perform_action(wezterm.action{SpawnCommandInNewTab={
    args={
      "vim", name,
    },
  }
  }, pane)

  -- wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous
  -- wrt. running this script and are not awaitable, so we just pick
  -- a number.
  wezterm.sleep_ms(1000);
  os.remove(name);
end)

return {

  -- padding
  window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
  },

  -- general options
  adjust_window_size_when_changing_font_size = false,
  debug_key_events = true,
  enable_tab_bar = false,
  native_macos_fullscreen_mode = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  color_scheme = "Catppuccin Mocha", -- or Macchiato, Frappe, Latte
  font_size = 13.0,
  scrollback_lines = 3500,
  enable_scroll_bar = false,

  keys = {
      { key="E", mods="CTRL", action=wezterm.action{EmitEvent="trigger-vim-with-scrollback"} },
      k.cmd_key(".", k.multiple_actions(":ZenMode")),
      k.cmd_key("[", act.SendKey({ mods = "CTRL", key = "o" })),
      k.cmd_key("]", act.SendKey({ mods = "CTRL", key = "i" })),
      k.cmd_key("f", k.multiple_actions(":Grep")),
      k.cmd_key("i", k.multiple_actions(":SmartGoTo")),
      k.cmd_key("p", k.multiple_actions(":GoToFile")),
      k.cmd_key("q", k.multiple_actions(":qa!")),

      k.cmd_key("H", act.SendKey({ mods = "CTRL", key = "h" })),
      k.cmd_key("J", act.SendKey({ mods = "CTRL", key = "j" })),
      k.cmd_key("K", act.SendKey({ mods = "CTRL", key = "k" })),
      k.cmd_key("L", act.SendKey({ mods = "CTRL", key = "l" })),
      k.cmd_key("P", k.multiple_actions(":GoToCommand")),

      k.cmd_to_tmux_prefix("1", "1"),
      k.cmd_to_tmux_prefix("2", "2"),
      k.cmd_to_tmux_prefix("3", "3"),
      k.cmd_to_tmux_prefix("4", "4"),
      k.cmd_to_tmux_prefix("5", "5"),
      k.cmd_to_tmux_prefix("6", "6"),
      k.cmd_to_tmux_prefix("7", "7"),
      k.cmd_to_tmux_prefix("8", "8"),
      k.cmd_to_tmux_prefix("9", "9"),

      k.cmd_to_tmux_prefix("`", "n"),
      k.cmd_to_tmux_prefix("b", "B"),
      k.cmd_to_tmux_prefix("C", "C"),
      k.cmd_to_tmux_prefix("d", "D"),
      k.cmd_to_tmux_prefix("E", "%"),
      k.cmd_to_tmux_prefix("e", '"'),
      k.cmd_to_tmux_prefix("G", "G"),
      k.cmd_to_tmux_prefix("g", "g"),
      k.cmd_to_tmux_prefix("j", "O"),
      k.cmd_to_tmux_prefix("k", "T"),
      k.cmd_to_tmux_prefix("l", "L"),
      k.cmd_to_tmux_prefix("n", '"'),
      k.cmd_to_tmux_prefix("N", "%"),
      k.cmd_to_tmux_prefix("o", "u"),
      k.cmd_to_tmux_prefix("T", "!"),
      k.cmd_to_tmux_prefix("t", "c"),
      k.cmd_to_tmux_prefix("w", "x"),
      k.cmd_to_tmux_prefix("z", "z"),

      k.cmd_key(
              "R",
              act.Multiple({
                      act.SendKey({ key = "\x1b" }), -- escape
                      k.multiple_actions(":source %"),
              })
      ),

      k.cmd_key(
              "s",
              act.Multiple({
                      act.SendKey({ key = "\x1b" }), -- escape
                      k.multiple_actions(":w"),
              })
      ),

      {
              mods = "CMD|SHIFT",
              key = "}",
              action = act.Multiple({
                      act.SendKey({ mods = "CTRL", key = "a" }),
                      act.SendKey({ key = "n" }),
              }),
      },
      {
              mods = "CMD|SHIFT",
              key = "{",
              action = act.Multiple({
                      act.SendKey({ mods = "CTRL", key = "a" }),
                      act.SendKey({ key = "p" }),
              }),
      },

      {
              mods = "CTRL",
              key = "Tab",
              action = act.Multiple({
                      act.SendKey({ mods = "CTRL", key = "a" }),
                      act.SendKey({ key = "n" }),
              }),
      },

      {
              mods = "CTRL|SHIFT",
              key = "Tab",
              action = act.Multiple({
                      act.SendKey({ mods = "CTRL", key = "a" }),
                      act.SendKey({ key = "p" }),
              }),
      },

      {
              mods = "CMD",
              key = "~",
              action = act.Multiple({
                      act.SendKey({ mods = "CTRL", key = "a" }),
                      act.SendKey({ key = "p" }),
              }),
      },
      },
}
