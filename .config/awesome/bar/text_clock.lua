local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local widget = {}

-- Right widgets -- 
local systray = wibox.widget.systray()

-- Textclock
local textclock = wibox.widget.textclock("%a %B %d, %H:%M", 60)
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

-- TODO split into textclock_widget and calendar_widget
textclock_widget:connect_signal('mouse::leave', function(c)
  if calendar_popup.visible then
    calendar_popup.visible = not calendar_popup.visible
  else
    calendar_popup:move_next_to(mouse.current_widget_geometry)
  end
end)

return textclock_widget
