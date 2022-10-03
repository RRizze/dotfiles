local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Right widgets -- 
local systray = wibox.widget.systray()

-- Keyboard
local keyboard = awful.widget.keyboardlayout()
keyboard_icon = { text = '', color = beautiful.colors.color4 }
local keyboard_widget = helpers.widget_with_icon(keyboard_icon, keyboard)

-- Volume
local volume_widget = require("bar.volume_widget")

-- Bookmark
local bookmark_widget = require("bar.bookmark_widget")

-- right widget
local right_widgets = wibox.widget {
  {
    {
      nil,
      nil,
      -- mic,
      -- volume,
      systray,
      -- calendar,
      volume_widget,
      keyboard_widget,
      bookmark_widget,
      spacing = 22,
      layout = wibox.layout.fixed.horizontal
    },
    right = dpi(10),
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
}

return right_widgets
