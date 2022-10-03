local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local button_commands = {
    ['close'] = { fun = function(c) c:kill() end, track_property = nil } ,
    ['maximize'] = { fun = function(c) c.maximized = not c.maximized; c:raise() end, track_property = "maximized" },
    ['minimize'] = { fun = function(c) c.minimized = true end },
    ['sticky'] = { fun = function(c) c.sticky = not c.sticky; c:raise() end, track_property = "sticky" },
    ['ontop'] = { fun = function(c) c.ontop = not c.ontop; c:raise() end, track_property = "ontop" },
    ['floating'] = { fun = function(c) c.floating = not c.floating; c:raise() end, track_property = "floating" },
}

local btn_window = function(c, shape, color, unfocused_color, hover_color, size, margin, cmd)
  local btn = wibox.widget {
    forced_width = size,
    forced_height = size,
    bg = color,
    shape = gears.shape.circle,
    widget = wibox.container.background
  }

  local btn_widget = wibox.widget {
    btn,
    margins = margin,
    widget = wibox.container.margin
  }

  return btn_widget
end

local btn_txt_window = function(c, symbol, color, unfocused_color, hover_color, size, margin, cmd)
  local btn = wibox.widget {
    forced_width = size + margin * 2,
    forced_height = size + margin * 2,
    markup = helpers.colorize_text(symbol, color),
    align = "center",
    valign = "center",
    font = beautiful.font,
    widget = wibox.widget.textbox
  }

  local p = button_commands[cmd].track_property

  if p then
  else
  end 

  btn:buttons(gears.table.join(
      awful.button({ }, 1, function ()
          button_commands[cmd].fun(c)
      end)
  ))

  btn:connect_signal("mouse::enter", function()
    btn.markup = helpers.colorize_text(symbol, hover_color)
  end)
  btn:connect_signal("mouse::leave", function()
    btn.markup = helpers.colorize_text(symbol, color)
  end)
  c:connect_signal("unfocus", function()
    btn.markup = helpers.colorize_text(symbol, unfocused_color)
  end)
  c:connect_signal("focus", function()
    btn.markup = helpers.colorize_text(symbol, color)
  end)

  return btn
end

local btn_shape = gears.shape.circle
local btn_size = dpi(12)
local btn_margin = dpi(8)
local btn_color_unfocused = beautiful.colors.color8
local btn_close_colors = {
  main = beautiful.colors.color9,
  unfocused = btin_color_unfocused,
  hover = beautiful.colors.color1
}

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    local top_titlebar = awful.titlebar(c, {
      font = beautiful.font,
      position = beautiful.titlebar_position,
      size = beautiful.titlebar_size,
    })
    -- buttons for the titlebar
    --local buttons = gears.table.join(
        --awful.button({ }, 1, function()
          --button_commands[cmd].fun(c)
            --c:emit_signal("request::activate", "titlebar", {raise = true})
            --awful.mouse.client.move(c)
        --end)--,
        --awful.button({ }, 3, function()
            --c:emit_signal("request::activate", "titlebar", {raise = true})
            --awful.mouse.client.resize(c)
        --end)
    --)

    top_titlebar : setup {
        nil,
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            nil,
     --       buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        {
          --awful.titlebar.widget.floatingbutton (c),
          --awful.titlebar.widget.maximizedbutton(c),
          --awful.titlebar.widget.stickybutton   (c),
          --awful.titlebar.widget.ontopbutton    (c),
          --awful.titlebar.widget.closebutton    (c),
          btn_txt_window(c, "", beautiful.colors.color3,
            btn_color_unfocused, beautiful.colors.color11,
            btn_size, btn_margin, "close"),
          btn_txt_window(c, "", beautiful.colors.color2,
            btn_color_unfocused, beautiful.colors.color10,
            btn_size, btn_margin, "close"),
          btn_txt_window(c, "", beautiful.colors.color1,
            btn_color_unfocused, beautiful.colors.color9,
            btn_size, btn_margin, "close"),
          {
            margins = btn_margin/ 2,
            widget = wibox.container.margin
          },
          layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)
