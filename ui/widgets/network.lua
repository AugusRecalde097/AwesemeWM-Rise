-- ui/widgets/network.lua
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local icon = wibox.widget {
    font = beautiful.font_name .. "14",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local container = wibox.widget {
    icon,
    bg = beautiful.lighter_bg,
    shape = require("helpers").rrect(beautiful.bar_radius),
    widget = wibox.container.background,
    set_icon = function(self, txt)
        icon.text = txt
    end
}

-- Actualizar automáticamente usando un timer
gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function()
        -- Detectar si hay Wi-Fi o Ethernet
        local handle = io.popen("ip route | grep default")
        local result = handle:read("*a")
        handle:close()

        if result:match("wlan") then
            container:set_icon("")  -- Ícono Wi-Fi
        elseif result:match("eth") then
            container:set_icon("󰈀")  -- Ícono Ethernet
        else
            container:set_icon("")  -- Desconectado
        end
    end
}

return container
