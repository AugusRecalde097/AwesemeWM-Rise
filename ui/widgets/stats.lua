local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local dpi = require("beautiful.xresources").apply_dpi

local cpu_text = wibox.widget {
    font = beautiful.font_name .. " 11",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local ram_text = wibox.widget {
    font = beautiful.font_name .. " 11",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local stats_widget = wibox.widget {
    {
        {
            cpu_text,
            ram_text,
            spacing = dpi(6),
            layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(6),
        widget = wibox.container.margin
    },
    bg = beautiful.lighter_bg,
    fg = beautiful.fg_normal,
    shape = helpers.rrect(beautiful.bar_radius),
    widget = wibox.container.background
}

-- Función para leer uso de CPU y RAM
gears.timer {
    timeout = 3,
    autostart = true,
    call_now = true,
    callback = function()
        -- CPU %
        local cpu = tonumber(io.popen("grep 'cpu ' /proc/stat"):read("*l"):match("cpu%s+(%d+)"))
        local total = tonumber(io.popen("grep 'cpu ' /proc/stat"):read("*a"):match("cpu%s+(%d+)"))
        local cpu_usage = cpu and total and math.floor((cpu / total) * 100) or 0

        -- RAM %
        local meminfo = io.popen("free -m"):read("*a")
        local total_mem = tonumber(meminfo:match("Mem:%s+(%d+)"))
        local used_mem = tonumber(meminfo:match("Mem:%s+%d+%s+(%d+)"))
        local ram_usage = total_mem and used_mem and math.floor((used_mem / total_mem) * 100) or 0

        cpu_text.markup = helpers.colorize_text("󰍛 " .. cpu_usage .. "%", beautiful.xcolor4)
        ram_text.markup = helpers.colorize_text("󰘚 " .. ram_usage .. "%", beautiful.xcolor3)
    end
}

return stats_widget
