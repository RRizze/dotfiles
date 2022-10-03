local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local ICON_DIR = '/home/sc3ptrr/dev/awesome-wm-tutorials/bookmark-widget/icons/'
local menu_items = {
  { name = 'Exit', font_icon = '', color = beautiful.colors.color10 },
  { name = 'Reboot', font_icon = '', color = beautiful.colors.color1 },
  { name = 'Power off', font_icon = '', color = beautiful.colors.color1 },
}

local popup = awful.popup {
  ontop = true,
  visible = false, -- should be hidden when created
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
  border_width = 2,
  border_color = beautiful.bg_focus,
  maximum_width = 500,
  offset = { y = 4, x = -4 },
  widget = {},
}

local cirlce_shape = function(cr, width, height)
  gears.shape.circle(cr, width, height)
end

local rrect_c = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

local red_circle_shape = wibox.widget {
  bg = "#343434",
  shape = gears.shape.circle,
  forced_height = dpi(1),
  forced_width = dpi(1),
  widget = wibox.container.background
}

local rows = { layout = wibox.layout.flex.vertical }
local rows_outer = { layout = wibox.layout.flex.vertical }


for _, item in ipairs(menu_items) do
  local row = helpers.button_with_text({
    text_icon = item.font_icon,
    text = item.name,
    color = item.color,
    text_icon_size = 11,
  })

  local old_cursor, old_wibox
  row:connect_signal('mouse::enter', function(c)
    c:set_bg(beautiful.bg_focus)
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = 'hand1'
  end)

  row:connect_signal('mouse::leave', function(c)
    c:set_bg(beautiful.bg_normal)
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)

  table.insert(rows, row)
end
table.insert(rows, red_circle_shape)

-- do i need this? or buttons should be rounded?

local margin_container = wibox.widget {
  rows,
  margins = 0,
  widget = wibox.container.margin,
}

table.insert(rows_outer, margin_container) 

popup:setup(rows_outer)

local bookmark_widget = helpers.button({
  text_icon = '',
  color = beautiful.colors.foreground,
})

bookmark_widget.buttons = 
  gears.table.join(
    awful.button({}, 1, function()
      if popup.visible then
        popup.visible = not popup.visible
      else
        popup:move_next_to(mouse.current_widget_geometry)
      end
  end))

return bookmark_widget
