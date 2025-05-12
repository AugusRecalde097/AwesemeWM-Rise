local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local dpi = require("beautiful.xresources").apply_dpi

-- Icono + IP
local net_text = wibox.widget {
    font = beautiful.font_name .. " 12",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

-- Contenedor visual
local network_widget = wibox.widget {
    {
        net_text,
        margins = dpi(6),
        widget = wibox.container.margin
    },
    bg = beautiful.lighter_bg,
    fg = beautiful.fg_normal,
    shape = helpers.rrect(beautiful.bar_radius),
    widget = wibox.container.background
}

-- Función para obtener la IP
local function get_ip()
    local handle = io.popen("ip -4 addr show | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}' | grep -v 127")
    local result = handle:read("*a") or ""
    handle:close()
    return result:match("[^\n]+") or "Sin IP"
end

-- Actualización periódica
gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function()
        local ip = get_ip()
        local icon = "󰈀"  -- Ethernet por defecto

        -- Detectar si es Wi-Fi
        local route = io.popen("ip route | grep default"):read("*a") or ""
        if route:match("wlan") then
            icon = ""
        elseif route == "" then
            icon = ""
            ip = "Desconectado"
        end

        net_text.markup = helpers.colorize_text(icon .. " " .. ip, beautiful.xcolor4)
    end
}

return network_widget
