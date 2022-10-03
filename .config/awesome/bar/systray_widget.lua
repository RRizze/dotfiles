local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local helpers = require('helpers')
-- TODO Systray
local systray_container = wibox.container.place()
local systray = wibox.widget.systray()
systray:set_base_size(22)
systray_container.valign = "center"
systray_container.halign = "center"
systray_container.widget = systray
