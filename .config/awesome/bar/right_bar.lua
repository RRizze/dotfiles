local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Right widgets -- 

-- Textclock
local textclock = wibox.widget.textclock("%A %B %d, %H:%M", 60)
textclock.valign = 'center'
textclock.align = 'center'
local textclock_icon = { text = '', color = beautiful.colors.color4 }
local textclock_widget = helpers.widget_with_icon(textclock_icon, textclock)

local calendar_popup = awful.popup {
  ontop = true,
  visible = false,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 8)
  end,
  border_width = 2,
  border_color = beautiful.bg_focus,
  maximum_width = 500,
  offset = { y = 5 },
  -- TODO placement
  --y = 40,
  --x = awful.screen.focused().geometry.width - 450,
  widget = {},
}

local test_txt = wibox.widget {
    widget = wibox.widget.textbox,
    text = 'TEST CALLENDAR HOIHOIHOI HOLA HOLA HOLA',
}

calendar_popup:setup {
  test_txt,
  margins = 4,
  widget = wibox.container.margin
}

textclock_widget:connect_signal('mouse::enter', function(c)
  if not calendar_popup.visible then
    --calendar_popup.visible = not calendar_popup.visible
    calendar_popup.visible = true
    calendar_popup:move_next_to(mouse.current_widget_geometry)
  end
end)

textclock_widget:connect_signal('mouse::leave', function(c)
  if calendar_popup.visible then
    calendar_popup.visible = not calendar_popup.visible
  else
    calendar_popup:move_next_to(mouse.current_widget_geometry)
  end
end)

-- Keyboard
local keyboard = awful.widget.keyboardlayout()
keyboard_icon = { text = '', color = beautiful.colors.color4 }
local keyboard_widget = helpers.widget_with_icon(keyboard_icon, keyboard)

-- Systray
local systray_container = wibox.container.place()
local systray = wibox.widget.systray()
systray:set_base_size(22)
systray_container.valign = "center"
systray_container.halign = "center"
systray_container.widget = systray


local bookmark_widget = require("bar.bookmark_widget")

-- right widget
local right_widgets = wibox.widget {
  {
    {
      nil,
      nil,
      -- mic,
      -- volume,
      -- systray,
      -- calendar,
      keyboard_widget,
      textclock_widget,
      bookmark_widget,
      spacing = 22,
      layout = wibox.layout.fixed.horizontal
    },
    margins = 0,
    widget = wibox.container.margin,
  },
  bg = beautiful.bg_normal,
  widget = wibox.container.background,
}

return right_widgets
