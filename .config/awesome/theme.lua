---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

--theme.font = "Fira Code Medium 14"
theme.font = "Hack Medium 14"
theme.icon_size = 12
--theme.icon_font = "Font Awesome 6 Free-Solid-900 " -- attention to space at the end!
theme.icon_color = "#587D8D"

local colors = {
    background = "#121212",
    foreground = "#dfdfe0",

    --black
    color0= "#1d1d1d",
    color8= "#475072",

    --red
    --color1= "#d05162",
    --color9= "#f56784",
    color1="#B56576",
    color9="#B56576",

    --green
    color2="#66B66E",
    color10="#66B66E",

    --yellow
    --color3= "#e5c179",
    --color11= "#e5c179",
    color3="#B4B666",
    color11="#B4B666",

    --blue
    color4= "#719cd6",
    color12= "#719cd6",

    --magenta
    color5= "#6666B6",
    color13= "#6666B6",

    --cyan
    color6= "#66A4B6",
    color14= "#66A4B6",

    --white
    color7= "#3c4854",
    color15= "#8F93A2",
}
theme.colors = colors

theme.bg_normal     = colors.background
theme.bg_focus      = colors.color0
theme.bg_urgent     = colors.background
theme.bg_minimize   = colors.background
theme.bg_systray    = colors.background

theme.fg_normal     = colors.foreground
theme.fg_focus      = colors.foreground
theme.fg_urgent     = colors.color1
theme.fg_minimize   = colors.foreground
theme.fg_occupied   = colors.color4

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = colors.background
theme.border_focus  = colors.color7
theme.border_marked = colors.color6

-- Taglist
theme.taglist_font = "icomoon 18"
theme.taglist_bg_focus = colors.color0
theme.taglist_fg_focus = colors.color3
theme.taglist_bg_occupied = colors.xolor3
theme.taglist_fg_occupied = colors.color4
theme.taglist_fg_empty = colors.color7
theme.taglist_bg_urgent = colors.background
theme.taglist_fg_urgent = colors.color1
--theme.taglist_text_font = "Font Awesome 6 Free-Solid-900 13, Fira Code medium 13"
--theme.taglist_spacing = dpi(20)
theme.taglist_disable_icon = true

local taglist_square_size = dpi(0)

theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.taglist_icons = {'', '', '', '', '', ''}

theme.taglist_text_color_empty = colors.color7
theme.taglist_text_color_occupied  = colors.color14
theme.taglist_text_color_focused  = colors.color2
theme.taglist_text_color_urgent   = colors.color1

-- Titlebar
theme.titlebars_enabled = false
theme.titlebar_position = "top"
theme.titlebar_size = dpi(0)
theme.titlebar_title_enabled = false
theme.titlebar_title_align = "center"
theme.titlebar_position = "top"
theme.titlebar_bg_normal = colors.background
theme.titlebar_fg_normal = colors.color7
theme.titlebar_bg_focus = colors.background
theme.titlebar_fg_focus = colors.foreground

-- Tasklist
theme.tasklist_disable_icon = true

local img_box = wibox.widget.imagebox()
img_box.image = "~/.config/awesome/themes/titlebar_icons/icons8-close-24.png"

--theme.titlebar_close_button_focus  = img_box
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(50)
theme.menu_width  = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
--theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
--theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_close_button_focus  = "~/.config/awesome/icons/red-skull.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/icons/yellow-skull.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/icons/yellow-skull.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/icons/yellow-skull.png"
theme.titlebar_maximized_button_focus_active = "~/.config/awesome/icons/yellow-skull.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"


--theme.wallpaper = "~/.config/awesome/bg.jpg"
theme.wallpaper = "~/.config/awesome/berserk.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
