local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- todo remove
local naughty = require("naughty")

local helpers = require("helpers")
local titlebars = {}

local wants_equal_padding
local anti_aliasing_padding = beautiful.border_radius * 2

if user.anti_aliasing then
  -- Function that returns true or false depending on whether the
  -- anti-aliasing titlebars should be added on all sides of a client or not.
  -- Padding is added under the top titlebar, and also titlebars are added to
  -- the left and right of the client in order to have equal padding on
  -- all sides. However they are not necessary for the anti aliasing itself
  -- and can be enabled or disabled per client in this function.
  -- ------------------
  wants_equal_padding = function(c)
    local class = c.class
    if  class == "kitty" or
        class == "editor" or
        class == "Nemo" or
        class == "music" or
        class == "email" or
        class == "htop" or
        class == "sensors" or
        class == "battop" or
        class == "mpvtube" or
        class == "scratchpad" or
        class == "Remacs" then
        return true
    else
        return false
    end
  end

  -- Only adds 4 anti_aliased titlebars of the same size around the client
  wants_only_borders = function(c)
    local class = c.class
    if  class == "feh" or
      class == "mpv" then
      return true
    else
      return false
    end
  end

else
  titlebar_container_shape = function()
      return gears.shape.rectangle
  end
end

-- Wrappers around awful.titlebar.hide and show
decorations = {}
if user.anti_aliasing then
    decorations.show = function(c)
        if wants_equal_padding(c) or wants_only_borders(c) then
            awful.titlebar.show(c, "left")
            awful.titlebar.show(c, "right")
        end
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
    end
    decorations.hide = function(c)
        if wants_equal_padding(c) or wants_only_borders(c) then
            awful.titlebar.hide(c, "left")
            awful.titlebar.hide(c, "right")
        end
        awful.titlebar.hide(c, "top")
        awful.titlebar.hide(c, "bottom")
    end
    decorations.toggle = function(c)
        if wants_equal_padding(c) or wants_only_borders(c) then
            awful.titlebar.toggle(c, "left")
            awful.titlebar.toggle(c, "right")
        end
        awful.titlebar.toggle(c, "top")
        awful.titlebar.toggle(c, "bottom")
    end
else
    decorations.show = function(c)
        awful.titlebar.show(c, beautiful.titlebar_position)
    end
    decorations.hide = function(c)
        awful.titlebar.hide(c, beautiful.titlebar_position)
    end
    decorations.toggle = function(c)
        awful.titlebar.toggle(c, beautiful.titlebar_position)
    end
end

return titlebars