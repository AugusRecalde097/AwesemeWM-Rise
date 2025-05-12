local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local helpers = require("helpers")

-- Íconos Nerd Font según estado del tag
local icons = {
    selected = "",  -- pacman (puede ser "󱐋", "󰊠", etc.)
    occupied = "",  -- ghost o similar
    empty    = "",  -- círculo vacío
}

local icon_color = {
  selected = beautiful.xcolor3, -- amarillo
  occupied = beautiful.xcolor4, -- azul
  empty = beautiful.xcolor8 -- gris
}

return function(s)
    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    local function update_icon(widget, tag)
        local txt, color
        if tag.selected then
            txt = icons.selected
            color = icon_color.selected
        elseif #tag:clients() > 0 then
            txt = icons.occupied
            color = icon_color.occupied
        else
            txt = icons.empty
            color = icon_color.empty
        end

        widget:get_children_by_id("icon_role")[1].markup = helpers.colorize_text(txt,color,1000)
    end

    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
              {
                {
                    id = "icon_role",
                    widget = wibox.widget.textbox,
                    font = beautiful.font_name .. "14",
                    align = "center",
                    valign = "center"
                },
                halign = "center",
                valign = "center",
                forced_width = dpi(42),
                forced_height = dpi(32),
                widget = wibox.container.place
              },
              widget = wibox.container.margin
            },
            shape = helpers.rrect(beautiful.border_radius),
            bg = beautiful.xcolor0,
            fg = beautiful.fg_normal,
            widget = wibox.container.background,

            create_callback = function(self, tag, _index, _)
                update_icon(self, tag)
                tag:connect_signal("property::selected", function()
                    update_icon(self, tag)
                end)
                tag:connect_signal("tagged", function()
                    update_icon(self, tag)
                end)
                tag:connect_signal("untagged", function()
                    update_icon(self, tag)
                end)
            end,

            update_callback = function(self, tag, _index, _)
                update_icon(self, tag)
            end
        },
        buttons = taglist_buttons
    }
end
