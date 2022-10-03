local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
--    

local volume_widget = helpers.button({
  text_icon = '' ,
  color = beautiful.colors.foreground
})

local volume_items = {
  { name = 'Volume:', font_icon ='', color = beautiful.colors.color7,
    volume_color = beautiful.colors.color2
  },
  { name = 'Volume:', font_icon ='', color = beautiful.colors.color7,
    volume_color = beautiful.colors.color2,
  },
  --{ name = '', font_icon ='', color = beautiful.colors.color7 },
}
-- Volume: =====*--

local popup = awful.popup {
  ontop = true,
  visible = false, -- should be hidden when created
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 12)
  end,
  border_width = 2,
  border_color = beautiful.bg_focus,
  maxium_width = 500,
  offset = { y = 4, x = -4 },
  widget = {},
}

local rows = { layout = wibox.layout.flex.vertical }

for _, item in ipairs(volume_items) do

  local row = wibox.widget {
    {
      {
        text = item.name,
        align = 'center',
        valign = 'center',
        font = 'icomoon 14',
        widget = wibox.widget.textbox
      },
      {
        -- this bar sits all width?
        id = 'bar',
        max_volume = 100,
        value = 70,
        forced_width = 100,
        forced_height = 10,
        color = beautiful.colors.color2,
        background_color = beautiful.bg_normal,
        margins = { top = 12, bottom = 10 },
        shape = gears.shape.rounded_bar,
        widget = wibox.widget.progressbar,
      },
      --forced_width = 100,
      --forced_height = 20,
      spacing = 14,
      layout = wibox.layout.fixed.horizontal,
    },
    margins = 8,
    widget = wibox.container.margin,
  }

  table.insert(rows, row)
end

popup:setup(rows)

volume_widget:buttons(
  awful.util.table.join(
    awful.button({}, 1, function()
      if popup.visible then
        popup.visible = not popup.visible
      else
        popup:move_next_to(mouse.current_widget_geometry)
      end
    end)
  )
)

return volume_widget
