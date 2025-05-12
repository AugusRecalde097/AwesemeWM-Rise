local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")

-- Widgets externos
local network = require("ui.widgets.network")

-- === WRAPPERS Y UTILIDADES ===

local wrap_widget = function(widget)
    return {
        widget,
        margins = dpi(4),
        widget = wibox.container.margin
    }
end

-- === ICONO DE AWESOME ===

local awesome_icon = wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = beautiful.awesome_logo,
        resize = true
    },
    margins = dpi(4),
    widget = wibox.container.margin
}

helpers.add_hover_cursor(awesome_icon, "hand2")
awesome_icon:buttons(gears.table.join(
    awful.button({}, 1, function () dashboard_toggle() end)
))

-- === BATERÍA (arcchart) ===

local charge_icon = wibox.widget{
    bg = beautiful.xcolor8,
    widget = wibox.container.background,
    visible = false
}

local batt = wibox.widget{
    charge_icon,
    color = {beautiful.xcolor2},
    bg = beautiful.xcolor8 .. "88",
    value = 50,
    min_value = 0,
    max_value = 100,
    thickness = dpi(4),
    padding = dpi(2),
    start_angle = math.pi * 3 / 2,
    widget = wibox.container.arcchart
}

awesome.connect_signal("signal::battery", function(value)
    local fill_color = beautiful.xcolor2
    if value >= 11 and value <= 30 then
        fill_color = beautiful.xcolor3
    elseif value <= 10 then
        fill_color = beautiful.xcolor1
    end
    batt.colors = {fill_color}
    batt.value = value
end)

awesome.connect_signal("signal::charger", function(state)
    charge_icon.visible = state
end)

-- === RELOJ ===

local hour = wibox.widget{
    font = beautiful.font_name .. "bold 14",
    format = "%H",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

local min = wibox.widget{
    font = beautiful.font_name .. "bold 14",
    format = "%M",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock
}

local clock = wibox.widget{
    {
        --format= '%H:%M:%S',
        font = beautiful.font_name .. "bold 12",
        align= "center",
        valign="center",
        widget = wibox.widget.textclock("%H:%M:%S", 1)
    },
    bg = beautiful.lighter_bg,
    fg = beautiful.fg_normal,
    shape = helpers.rrect(beautiful.bar_radius),
    widget = wibox.container.background,
    margins = dpi(5)
}

-- === STATS (reloj + batería) ===

local stats = wibox.widget{
    {
        wrap_widget(batt),
        clock,
        spacing = dpi(6),
        layout = wibox.layout.fixed.horizontal
    },
    bg = beautiful.xcolor0,
    shape = helpers.rrect(beautiful.bar_radius),
    widget = wibox.container.background,
    margins = dpi(4)
}

stats:connect_signal("mouse::enter", function()
    stats.bg = beautiful.xcolor8
    stats_tooltip_show()
end)

stats:connect_signal("mouse::leave", function()
    stats.bg = beautiful.xcolor0
    stats_tooltip_hide()
end)

-- === NOTIFICACIONES ===

local notifs = wibox.widget{
    markup = helpers.colorize_text("", beautiful.xcolor3),
    font = beautiful.font_name .. "15",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

notifs:connect_signal("mouse::enter", function()
    notifs.markup = helpers.colorize_text(notifs.text, beautiful.xcolor3 .. "55")
end)

notifs:connect_signal("mouse::leave", function()
    notifs.markup = helpers.colorize_text(notifs.text, beautiful.xcolor3)
end)

notifs:buttons(gears.table.join(
    awful.button({}, 1, function() notifs_toggle() end)
))
helpers.add_hover_cursor(notifs, "hand2")

-- === LAYOUTBOX ===

local function layoutbox_container(s)
    local layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons(gears.table.join(
        awful.button({}, 1, function () awful.layout.inc(1) end),
        awful.button({}, 3, function () awful.layout.inc(-1) end),
        awful.button({}, 4, function () awful.layout.inc(-1) end),
        awful.button({}, 5, function () awful.layout.inc(1) end)
    ))

    return wibox.widget {
        layoutbox,
        margins = dpi(6),
        widget = wibox.container.margin
    }
end

-- === BARRA POR PANTALLA ===

screen.connect_signal("request::desktop_decoration", function(s)

    s.mytaglist = require("ui.widgets.pacman_taglist")(s)

    s.mywibar = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(45),
        bg = beautiful.darker_bg,
        shape = helpers.rrect(beautiful.border_radius),
        ontop = true
    })

    s.mywibar:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",

            { -- izquierda
                layout = wibox.layout.fixed.horizontal,
                awesome_icon,
                spacing=dpi(6)
            },
            {
              s.mytaglist,
              bg = beautiful.xcolor0,
              shape = beautiful.taglist_shape_focus,
              widget = wibox.container.background
            }, -- centro (podés poner un tasklist si querés)
            { -- derecha
                layout = wibox.layout.fixed.horizontal,
                network,
                stats,
                notifs,
                layoutbox_container(s),
                spacing= dpi(6)
            }
        },
        margins = dpi(8),
        widget = wibox.container.margin
    }
end)
