
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local themes_path = os.getenv("HOME") .. ".config/awesome/themes/"
local theme_name = "onedark"
local this_theme_path = themes_path .. theme_name .. "/"

local theme = {}

-- This is used to make it easier to align the panels in specific monitor positions
local awful = require("awful")
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height


-- WALLPAPER
-- not used, we use ~/.fehbg instead
-- ==================================================================
-- theme.wallpaper = this_theme_path .. "wallpaper.jpg"


-- FONT
-- ==================================================================
theme.font = "Google Sans Medium 9"

-- COLORS
-- ==================================================================
-- Get colors from .Xresources and set fallback colors
theme.xbackground = xrdb.background or "#282c34"
theme.xforeground = xrdb.foreground or "#abb2bf"
theme.xcolor0 = xrdb.color0 or "#0f1011"
theme.xcolor1 = xrdb.color1 or "#e06c75"
theme.xcolor2 = xrdb.color2 or "#98c379"
theme.xcolor3 = xrdb.color3 or "#e5c07b"
theme.xcolor4 = xrdb.color4 or "#56b6c2"
theme.xcolor5 = xrdb.color5 or "#c678dd"
theme.xcolor6 = xrdb.color6 or "#61afef"
theme.xcolor7 = xrdb.color7 or "#3e4451"
theme.xcolor8 = xrdb.color8 or "#5C6370"
theme.xcolor9 = xrdb.color9 or "#e06c75"
theme.xcolor10 = xrdb.color10 or  "#98c379"
theme.xcolor11 = xrdb.color11 or  "#e5c07b"
theme.xcolor12 = xrdb.color12 or  "#56b6c2"
theme.xcolor13 = xrdb.color13 or  "#c678dd"
theme.xcolor14 = xrdb.color14 or  "#61afef"
theme.xcolor15 = xrdb.color15 or  "#ffffff"


-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark       = theme.xbackground
theme.bg_normal     = theme.xcolor0
theme.bg_focus      = theme.xcolor8
theme.bg_urgent     = theme.xcolor8
theme.bg_minimize   = theme.xcolor8
theme.bg_systray    = theme.xcolor8

theme.fg_normal     = theme.xcolor8
theme.fg_focus      = theme.xcolor4
theme.fg_urgent     = theme.xcolor3
theme.fg_minimize   = theme.xcolor8


-- GAPS
-- ==================================================================
theme.useless_gap   = dpi(5)

-- BORDERS
-- ==================================================================
theme.border_width  = dpi(3)
theme.border_normal = theme.xbackground
theme.border_focus  = theme.xcolor6
theme.border_marked = "#91231c"
-- Rounded corners
theme.border_radius = dpi(0)

-- TAGS
-- ==================================================================

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = this_theme_path.."submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- TITLEBARS
-- ==================================================================
theme.titlebars_enabled = false
theme.titlebar_title_enabled = false

-- Define the image to load
theme.titlebar_close_button_normal = this_theme_path.."titlebar/close_normal.png"
theme.titlebar_close_button_focus  = this_theme_path.."titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = this_theme_path.."titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = this_theme_path.."titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = this_theme_path.."titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = this_theme_path.."titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = this_theme_path.."titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = this_theme_path.."titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = this_theme_path.."titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = this_theme_path.."titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = this_theme_path.."titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = this_theme_path.."titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = this_theme_path.."titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = this_theme_path.."titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = this_theme_path.."titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = this_theme_path.."titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = this_theme_path.."titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = this_theme_path.."titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = this_theme_path.."titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = this_theme_path.."titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = this_theme_path.."layouts/fairhw.png"
theme.layout_fairv = this_theme_path.."layouts/fairvw.png"
theme.layout_floating  = this_theme_path.."layouts/floatingw.png"
theme.layout_magnifier = this_theme_path.."layouts/magnifierw.png"
theme.layout_max = this_theme_path.."layouts/maxw.png"
theme.layout_fullscreen = this_theme_path.."layouts/fullscreenw.png"
theme.layout_tilebottom = this_theme_path.."layouts/tilebottomw.png"
theme.layout_tileleft   = this_theme_path.."layouts/tileleftw.png"
theme.layout_tile = this_theme_path.."layouts/tilew.png"
theme.layout_tiletop = this_theme_path.."layouts/tiletopw.png"
theme.layout_spiral  = this_theme_path.."layouts/spiralw.png"
theme.layout_dwindle = this_theme_path.."layouts/dwindlew.png"
theme.layout_cornernw = this_theme_path.."layouts/cornernww.png"
theme.layout_cornerne = this_theme_path.."layouts/cornernew.png"
theme.layout_cornersw = this_theme_path.."layouts/cornersww.png"
theme.layout_cornerse = this_theme_path.."layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
