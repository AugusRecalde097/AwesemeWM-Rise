-- Standard awesome library
local gears = require("gears")
local gfs = require("gears.filesystem")

-- Theme handling library
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

-- Helpers
local helpers = require("helpers")


-- Theme
----------

-- Load ~/.Xresources colors
theme.xbackground = xrdb.background
theme.xforeground = xrdb.foreground
theme.xcolor0 = xrdb.color0
theme.xcolor1 = xrdb.color1
theme.xcolor2 = xrdb.color2
theme.xcolor3 = xrdb.color3
theme.xcolor4 = xrdb.color4
theme.xcolor5 = xrdb.color5
theme.xcolor6 = xrdb.color6
theme.xcolor7 = xrdb.color7
theme.xcolor8 = xrdb.color8
theme.xcolor9 = xrdb.color9
theme.xcolor10 = xrdb.color10
theme.xcolor11 = xrdb.color11
theme.xcolor12 = xrdb.color12
theme.xcolor13 = xrdb.color13
theme.xcolor14 = xrdb.color14
theme.xcolor15 = xrdb.color15
theme.darker_bg = "#0a1419"
theme.lighter_bg = "#162026"
theme.dashboard_fg = "#666c79"
theme.transparent = "#00000000"

-- PFP
theme.pfp = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/pfp.png")

-- Wallpaper
theme.wallpaper = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/bg.png")

-- Awesome Logo
theme.awesome_logo = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/icons/awesome.png")

-- Notifications icon
theme.notification_icon = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/icons/notification.png")
theme.volume_icon = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/icons/volume.svg")
theme.brightness_icon = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/icons/brightness.svg")

-- Fonts
theme.font_name = "Iosevka "
theme.font = theme.font_name .. "8"
theme.icon_font_name = "Material Icons "
theme.icon_font = theme.icon_font_name .. "18"
theme.font_taglist = theme.icon_font_name .. "13"

-- Background Colors
theme.bg_dark = theme.darker_bg
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xbackground
theme.bg_urgent = theme.xbackground
theme.bg_minimize = theme.xbackground
theme.bg_secondary = theme.darker_bg
theme.bg_accent = theme.lighter_bg

-- Foreground Colors
theme.fg_normal = theme.xforeground
theme.fg_focus = theme.xforeground
theme.fg_urgent = theme.xcolor1
theme.fg_minimize = theme.xcolor0

-- Borders
theme.border_width = dpi(0)
theme.oof_border_width = dpi(0)
theme.border_normal = theme.darker_bg
theme.border_focus = theme.darker_bg
theme.widget_border_width = dpi(0)
theme.widget_border_color = theme.darker_bg

-- Radius
theme.border_radius = dpi(12)
theme.client_radius = dpi(10)
theme.dashboard_radius = dpi(10)
theme.bar_radius = dpi(10)

-- Taglist
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg

theme.taglist_bg_focus = theme.lighter_bg
theme.taglist_fg_focus = theme.xcolor3

theme.taglist_bg_urgent = theme.wibar_bg
theme.taglist_fg_urgent = theme.xcolor6

theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.xcolor6

theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.xcolor8

theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11

theme.taglist_disable_icon = true

theme.taglist_shape_focus = helpers.rrect(theme.bar_radius)
theme.taglist_shape_empty = helpers.rrect(theme.bar_radius)
theme.taglist_shape = helpers.rrect(theme.bar_radius)
theme.taglist_shape_urgent = helpers.rrect(theme.bar_radius)
theme.taglist_shape_volatile = helpers.rrect(theme.bar_radius)

-- Titlebars
theme.titlebar_enabled = true
theme.titlebar_size = dpi(45)
theme.titlebar_unfocused = theme.xcolor0

-- Pop up notifications
theme.pop_size = dpi(200)
theme.pop_bg = theme.xbackground
theme.pop_bar_bg = theme.xcolor0
theme.pop_vol_color = theme.xcolor4
theme.pop_brightness_color = theme.xcolor5
theme.pop_fg = theme.xforeground
theme.pop_border_radius = theme.border_radius

-- Tooltip
theme.tooltip_bg = theme.xbackground
theme.tooltip_height = dpi(245)
theme.tooltip_width = dpi(200)
theme.tooltip_gap = dpi(10)
theme.tooltip_box_margin = dpi(10)
theme.tooltip_border_radius = theme.border_radius
theme.tooltip_box_border_radius = theme.bar_radius

-- Edge snap
theme.snap_bg = theme.xcolor8
theme.snap_shape = helpers.rrect(0)

-- Prompts
theme.prompt_bg = transparent
theme.prompt_fg = theme.xforeground

-- dashboard
theme.dashboard_width = dpi(300)
theme.dashboard_box_bg = theme.lighter_bg
theme.dashboard_box_fg = theme.dashboard_fg

-- Playerctl
theme.playerctl_ignore  = {"firefox", "qutebrowser", "chromium", "brave"}
theme.playerctl_player  = {"spotify", "mpd", "%any"}
theme.playerctl_update_on_activity = true
theme.playerctl_position_update_interval = 1

-- Mainmenu
theme.menu_font = theme.font_name .. "10"
theme.menu_height = dpi(30) 
theme.menu_width = dpi(150) 
theme.menu_bg_normal = theme.xbackground
theme.menu_bg_focus = theme.lighter_bg
theme.menu_fg_normal= theme.xforeground
theme.menu_fg_focus= theme.xcolor4
theme.menu_border_width = dpi(0)
theme.menu_border_color = theme.xcolor0
theme.menu_submenu = "»  "
theme.menu_submenu_icon = nil

-- Hotkeys Pop Up
theme.hotkeys_bg = theme.xbackground
theme.hotkeys_fg = theme.xforeground
theme.hotkeys_modifiers_fg = theme.xforeground
theme.hotkeys_font = theme.font_name .. "10"
theme.hotkeys_description_font = theme.font_name .. "9"
theme.hotkeys_shape = helpers.rrect(theme.border_radius)
theme.hotkeys_group_margin = dpi(30)

-- Layout List
theme.layoutlist_border_color = theme.lighter_bg
theme.layoutlist_border_width = theme.border_width
theme.layoutlist_shape_selected = helpers.rrect(dpi(10))
theme.layoutlist_bg_selected = theme.lighter_bg

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xforeground)

-- Gaps
theme.useless_gap = dpi(5)

-- Wibar
theme.wibar_width = dpi(45)
theme.wibar_bg = theme.xbackground
theme.wibar_position = "left"

-- Tabs
theme.mstab_bar_height = dpi(60)
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = theme.border_radius
theme.tabbar_disable = true
theme.tabbar_style = "modern"
theme.tabbar_bg_focus = theme.lighter_bg
theme.tabbar_bg_normal = theme.darker_bg
theme.tabbar_fg_focus = theme.xforeground
theme.tabbar_fg_normal = theme.xcolor0
theme.tabbar_position = "bottom"
theme.tabbar_AA_radius = 0
theme.tabbar_size = 40
theme.mstab_bar_ontop = true

-- Notifications
theme.notification_spacing = 19
theme.notification_border_radius = dpi(6)
theme.notification_border_width = dpi(0)

-- Swallowing
theme.dont_swallow_classname_list = {
    "firefox", "gimp", "Google-chrome", "Thunar"
}

-- Layout Machi
theme.machi_switcher_border_color = theme.darker_bg
theme.machi_switcher_border_opacity = 0.25
theme.machi_editor_border_color = theme.darker_bg
theme.machi_editor_border_opacity = 0.25
theme.machi_editor_active_opacity = 0.25

-- Tag Preview
theme.tag_preview_client_border_radius = dpi(6)
theme.tag_preview_client_opacity = 0.1
theme.tag_preview_client_bg = theme.xbackground
theme.tag_preview_client_border_color = theme.darker_bg
theme.tag_preview_client_border_width = theme.widget_border_width

theme.tag_preview_widget_border_radius = theme.border_radius
theme.tag_preview_widget_bg = theme.xbackground
theme.tag_preview_widget_border_color = theme.widget_border_color
theme.tag_preview_widget_border_width = theme.widget_border_width * 0
theme.tag_preview_widget_margin = dpi(10)

-- Task Preview
theme.task_preview_widget_border_radius = dpi(10)
theme.task_preview_widget_bg = theme.xbackground
theme.task_preview_widget_border_color = theme.widget_border_color
theme.task_preview_widget_border_width = theme.widget_border_width * 0
theme.task_preview_widget_margin = dpi(15)

theme.fade_duration = 250

return theme
