-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("awful.hotkeys_popup.keys")
local helpers = require("helpers")
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

--awful.titlebar.enable_tooltip = false

local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

local tags = {
    names = {
        '',
        '',
        '',
        '',
        '',
        '',
    }
}

tags.layout = {
    layouts[6],
    layouts[6],
    layouts[6],
    layouts[6],
    layouts[6],
    layouts[1],
}

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium"
filemanager_cmd = terminal .. " -e " .. "nnn"
runner = "rofi -show run"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

--beautiful.awesome_icon 
mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu},
        { "open terminal", terminal },
        { "Power Off"}
    }
})

local my_imagebox = wibox.widget {
  image = beautiful.awesome_icon,
  resize = true,
  forced_height = 32,
  forced_width = 32,
  valign = center,
  halign = center,
  widget = wibox.widget.imagebox
}

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end))

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        --gears.wallpaper.maximized(wallpaper, s, true)
        --gears.wallpaper.centered(wallpaper, s, 1)
        awful.spawn.with_shell("feh --bg-fill ~/.config/awesome/bg.jpg")
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)
--screen.connect_signal("property::geometry", function()awful.spawn.with_shell("feh --bg-fill ~/.config/awesome/bg")end)


------------- Bar ------------------------------------------

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    --set_wallpaper(s)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    local function add_text_to_container(container, tag, index)
        local text_widget = wibox.widget{
            align  = 'center',
            valign = 'center',
            --forced_width = dpi(25),
            widget = wibox.widget.textbox
        }
        --update particular tag
        helpers.update_taglist(text_widget, tag, index, container)
        container.widget = text_widget
        return container
    end

    local taglist_container = helpers.container(dpi(2), dpi(10))

    taglist_container.widget = awful.widget.taglist {
    --my_taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout = {
            spacing = dpi(0),
            forced_width = dpi(300),
            layout = wibox.layout.flex.horizontal,
        },
        widget_template = {
            left = dpi(0),
            right = dpi(0),
            bottom = dpi(2),
            top = dpi(0),
            widget = wibox.container.margin,
            create_callback = function(self, tag, index, _)
                add_text_to_container(self, tag, index)
            end,
            update_callback = function(self, tag, index, _)
                add_text_to_container(self, tag, index)
            end,
        },
    }

    s.mytaglist = taglist_container

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    local function create_boxed_widget(widget, width, height, bg_color, gap)
      local bg_container = wibox.container.background()
      bg_container.bg = bg_color
      bg_container.forced_width = width
      bg_container.forced_height = height
      bg_container.shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, widht, height, 8)
      end

      local boxed_widget = wibox.widget {
        --margins
        {
          -- bg
          {
            -- centered widget horizontally
            nil,
            {
              nil,
              widget,
              layout = wibox.layout.align.vertical,
              expand = 'none'
            },
            layout = wibox.layout.align.horizontal,
            expand = 'none'
          },
          widget = bg_container
        },
        margins = gap,
        color = '#FF000000',
        widget = wibox.container.margin
      }
      return boxed_widget
    end


    -- Middle Widgets



    -- Right widgets -- 
    local right_widgets = require('bar.right_bar')
    local textclock_widget = require('bar.text_clock')





    wibox_test = wibox.widget {
      markup = "Gigachad",
      align = "center",
      valign = "center",
      --forced_width = 20,
      widget = wibox.widget.textbox
    }


    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            { -- left widgets

                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                s.mypromptbox,
                --s.mytasklist,
            },
            nil,
            { -- right widgets
                right_widgets,
                layout = wibox.layout.align.horizontal,
            },
        },
        {
            textclock_widget,
            valign = "center",
            halign = "center",
            layout = wibox.container.place
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {description="show help", group="awesome"}),
    awful.key({ modkey }, "Left", awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right", awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    -- remove
    awful.key({ modkey }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),

    awful.key({ modkey }, "j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- change window or delete
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show()
        end,
        {description = "show main menu", group = "awesome"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j",
        function ()
            awful.client.swap.byidx(  1)
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key({ modkey, "Shift" }, "k",
        function ()
            awful.client.swap.byidx( -1)
        end,
        {description = "swap with prev client by index", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "j",
        function ()
            awful.screen.focus_relative( 1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key({ modkey, "Control" }, "k",
        function ()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),

    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),

    -- Standard program
    awful.key({ modkey }, "Return",
        function ()
          awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    awful.key({ modkey }, "p",
      function()
        awful.util.spawn_with_shell("sleep 0.5 && scrot -s -F ~/screenshots/%Y-%m-%d-%T-sshot.png -z")
      end,
      { description = "get screenshot", group = "launcher" }
    ),
    -- not work or did not see
    awful.key({ modkey }, "l",
        function ()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key({ modkey }, "h",
        function ()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key({ modkey, "Shift" }, "h",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, "Shift" }, "l",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, "Control" }, "h",
        function () awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key({ modkey, "Control" }, "l",
        function ()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    -- end of NOT WROKING BINDINGS

    awful.key({ modkey }, "space",
        function ()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    awful.key({ modkey, "Shift" }, "space",
        function ()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),
    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize",
                  { raise = true }
                )
            end
        end,
        {description = "restore minimized", group = "client"}
    ),

    -- My programs
    --  mod+c
    awful.key({ modkey }, "c",
        function ()
            awful.spawn(browser)
        end,
        {description = "open a browser", group = "fractl"}
    ),
    -- mod + v
    awful.key({ modkey }, "v",
        function ()
            awful.spawn(filemanager_cmd)
        end,
        {description = "open a filemanager", group = "fractl"}
    ),
    -- telegram, firefox?
    -- mod + x

    -- Rofi
    -- awful.screen.focused().mypromptbox:run()
    awful.key({ modkey }, "r",function() awful.spawn(runner) end, 
        {description = "run rofi", group = "launcher"}),

    -- remove/change this binding
    awful.key({ modkey }, "x",
        function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"})
    -- Menubar
    -- ???
    --awful.key({ modkey }, "p", function() menubar.show() end,
     --         {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {
          description = "toggle fullscreen", group = "client"
        }
    ),

    awful.key({ modkey }, "q",
        function (c)
          c:kill()
        end,
        {
          description = "close", group = "client"
        }
    ),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
      rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    {
      rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
      properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    {
      rule_any = {
        type = {
          "normal", "dialog"
        }
      },
      properties = {
        titlebars_enabled = true
      }
    },

    -- Set Chromium to always map on the tag named "2" on screen 1.
    {
      rule = {
        class = {
          "Chromium",
          "Chromium-browser"
        }
      },
      properties = {
        screen = 1,
        tag = "",
        floating = false
      }
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    --if awesome.startup
    --  and not c.size_hints.user_position
    --  and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
    --    awful.placement.no_offscreen(c)
    --end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
require("bar.titlebar")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

if beautiful.border_width > 0 then
  client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
  client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

-- When a client starts up in fullscreen, resize it to cover the fullscreen a short moment later
-- Fixes wrong geometry when titlebars are enabled
client.connect_signal("manage", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

-- only 1 client
-- changes doens't applay after moving on workspaces
screen.connect_signal("arrange", function (s)
  local only_one = #s.tiled_clients == 1
  for _, c in pairs(s.clients) do
    if only_one and not c.floating or c.maximized then
      c.border_width = 0
      beautiful.useless_gap = 0
    else
      c.border_width = beautiful.border_width -- your border width
      --beautiful.useless_gap = dpi(5)
    end
  end
end)

awful.spawn.with_shell("picom")
awful.spawn.with_shell("feh --bg-fill ~/.config/awesome/bg.jpg")
