local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local naughty = require("naughty")

local helpers = {}


-- Helper function that updates a taglist item
function helpers.update_taglist(text_widget, tag, index, container)
  if tag.selected then
    text_widget.markup = helpers.colorize_text(
      beautiful.taglist_icons[index],
      beautiful.taglist_text_color_focused
    )
    --container.color = beautiful.taglist_text_color_focused
  elseif tag.urgent then
    text_widget.markup = helpers.colorize_text(
      beautiful.taglist_icons[index],
      beautiful.taglist_text_color_urgent
    )
    --container.color = beautiful.bg_normal
  elseif #tag:clients() > 0 then
    text_widget.markup = helpers.colorize_text(
      beautiful.taglist_icons[index],
      beautiful.taglist_text_color_occupied
    )
    --container.color = beautiful.bg_normal
  else
    text_widget.markup = helpers.colorize_text(
      beautiful.taglist_icons[index],
      beautiful.taglist_text_color_empty
    )
    --container.color = beautiful.bg_normal
   end
end


helpers.colorize_text = function(text, color)
  return "<span foreground='"..color.."'>"..text.."</span>"
end

function helpers.container(left, right, top, bottom)
    local c = wibox.container.margin()
    c.left = left or 0
    c.right = right or 0
    c.top = top or 0
    c.bottom = bottom or 0
    return c
end

function helpers.add_icon(widget, icon)
  local container = wibox.layout.fixed.horizontal()
  container.spacing = 10
  local textbox = wibox.widget.textbox()
  textbox.markup = ""..icon
  container:add(textbox)
  container:add(widget)
  return container
end

function helpers.button(args)
  local color = args.color or beautiful.colors.foreground
  local text_icon = args.text_icon or ''
  local top = args.top or 0
  local bottom = args.bottom or 0
  local left = args.left or 0
  local right = args.right or 0

  local button = wibox.widget {
    {
      {
        markup = helpers.colorize_text(text_icon, color),
        align = 'center',
        font = 'icomoon 15',
        valign = 'center',
        forced_height = 34,
        forced_width = 34,
        widget = wibox.widget.textbox
      },
      top = top,
      bottom = bottom,
      left = left,
      right = right,
      widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }

  local old_cursor, old_wibox

  button:connect_signal('mouse::enter', function(c)
    c:set_bg(beautiful.bg_focus)
    local wbox = mouse.current_wibox
    old_cursor, old_wibox = wbox.cursor, wbox
    wbox.cursor = 'hand1'
  end)

  button:connect_signal('mouse::leave', function(c)
    c:set_bg(beautiful.bg_normal)
    if old_wibox then
      old_wibox.cusor = old_cursor
      old_wibox = nil
    end
  end)
  local btn_press_color = '#303030'

  button:connect_signal('button::press', function(c)
    c:set_bg(btn_press_color)
    if button == 1 then  naughty.notify{text = 'Left click'} 
    elseif button == 2 then naughty.notify{text = 'Wheel click'} 
    elseif button == 3 then naughty.notify{text = 'Right click'} 
    end
  end)

  button:connect_signal('button::release', function(c)
    c:set_bg(beautiful.bg_focus)
  end)

  return button
end

-- text_icon + text
function helpers.button_with_text(args)
  local color = args.color or beautiful.colors.foreground
  local text_icon = args.text_icon or ''
  local text_icon_size = args.text_icon_size or 14
  local text = args.text or ''

  local button = wibox.widget {
    {
      {
        {
          {
            markup = helpers.colorize_text(text_icon, color),
            align = 'center',
            font = 'icomoon '..text_icon_size,
            valign = 'center',
            forced_height = 34,
            forced_width = 34,
            widget = wibox.widget.textbox
          },
          margins = 0,
          widget = wibox.container.margin
        },
        {
          text = text,
          font = 'Fira Code medium 11',
          valign = 'center',
          align = 'center',
          widget = wibox.widget.textbox
        },
        spacing = 8,
        layout = wibox.layout.fixed.horizontal
      },
      --margins = 4,
      top = 2,
      bottom = 2,
      left = 6,
      right = 6,
      widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }

  local old_cursor, old_wibox

  button:connect_signal('mouse::enter', function(c)
    c:set_bg(beautiful.bg_focus)
    local wbox = mouse.current_wibox
    old_cursor, old_wibox = wbox.cursor, wbox
    wbox.cursor = 'hand1'
  end)

  button:connect_signal('mouse::leave', function(c)
    c:set_bg(beautiful.bg_normal)
    if old_wibox then
      old_wibox.cusor = old_cursor
      old_wibox = nil
    end
  end)
  local btn_press_color = '#303030'

  button:connect_signal('button::press', function(c)
    c:set_bg(btn_press_color)
    if button == 1 then  naughty.notify{text = 'Left click'} 
    elseif button == 2 then naughty.notify{text = 'Wheel click'} 
    elseif button == 3 then naughty.notify{text = 'Right click'} 
    end
  end)

  button:connect_signal('button::release', function(c)
    c:set_bg(beautiful.bg_focus)
  end)

  return button
end

-- icon -> table {text = '', color = ''}
function helpers.widget_with_icon(icon, inner_widget)
  return wibox.widget {
    {
      {
        {
          {
            markup = helpers.colorize_text(
              icon.text,
              icon.color or beautiful.colors.foreground
            ),
            font = 'icomoon 15',
            valign = 'center',
            align = 'center',
            widget = wibox.widget.textbox,
          },
          margins = 0,
          widget = wibox.container.margin
        },
        inner_widget,
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
      },
      margins = 0,
      widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }
end
return helpers

