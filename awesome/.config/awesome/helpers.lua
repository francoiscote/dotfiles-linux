 
-- Functions that you use more than once and in different files would
-- be nice to define here.
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")

local naughty = require("naughty")

local helpers = {}


-- Rounded Corners Rectangles
-- ==================================================================
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
        --gears.shape.octogon(cr, width, height, radius)
        --gears.shape.rounded_bar(cr, width, height)
    end
end

-- VOLUME
-- ==================================================================
local volume_get_cmd = "pulseaudio-ctl full-status | cut -d ' ' -f1"
local volume_notif
function helpers.volume_control(step) 
  local cmd
  if step == 0 then
      -- Toggle mute
      cmd = "pulseaudio-ctl mute"
      awful.spawn.with_shell(cmd)
      -- awful.spawn.easy_async_with_shell(cmd, function(out)
      --     local text
      --     if out:match('yes') then
      --         text = "Muted"
      --     else
      --         text = "Unmuted"
      --     end
      --     if not sidebar.visible then
      --         if volume_notif and not volume_notif.is_expired then
      --             volume_notif.message = text
      --         else
      --             volume_notif = naughty.notify({ title = "Volume", message = text, timeout = 2 })
      --         end
      --     end
      -- end)
  else
      if step > 0 then
          direction = "up"
      else
          direction = "down"
      end
      cmd = "pulseaudio-ctl "..direction.." "..tostring(step).." && "..volume_get_cmd
      awful.spawn.easy_async_with_shell(cmd, function(out)
          print(out)
          out = out:gsub('^%s*(.-)%s*$', '%1')
          print(out)
        --   if not sidebar.visible then
              if volume_notif and not volume_notif.is_expired then
                  volume_notif.message = out
              else
                  volume_notif = naughty.notify({ title = "Volume", message = out, timeout = 2 })
              end
          -- end

      end)
  end
end

-- TAGS BACK AND FORTH
-- ==================================================================
-- If you try to focus the same tag you are at, go back to the previous tag.
-- Useful for quick switching after for example checking an incoming chat
-- message at tag 2 and coming back to your work at tag 1 with the same
-- keypress
function helpers.tag_back_and_forth(tag_index)
    local s = mouse.screen
    local tag = s.tags[tag_index]
    if tag then
        if tag == s.selected_tag then
            awful.tag.history.restore()
        else
            tag:view_only()
        end
    end
end

-- RESIZE DWIM (Do What I Mean)
-- ==================================================================
-- Resize client or factor
local floating_resize_amount = dpi(20)
local tiling_resize_factor= 0.05
---------------
function helpers.resize_dwim(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(  0,  0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(  0,  0, 0,  floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(  0,  0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(  0,  0,  floating_resize_amount, 0)
        end
    else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact( tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact( tiling_resize_factor)
        end
    end
end

-- DOUBLE TAP
-- ==================================================================
local double_tap_timer = nil
function helpers.single_double_tap(single_tap_function, double_tap_function)
    if double_tap_timer then
        double_tap_timer:stop()
        double_tap_timer = nil
        double_tap_function()
        -- naughty.notify({text = "We got a double tap"})
        return
    end

    double_tap_timer =
        gears.timer.start_new(0.20, function()
            double_tap_timer = nil
            -- naughty.notify({text = "We got a single tap"})
            if single_tap_function then
                single_tap_function()
            end
            return false
        end)
end

-- MOVE TO EDGE
-- ==================================================================
-- Move client to screen edge, respecting the screen workarea
function helpers.move_to_edge(c, direction)
    local workarea = awful.screen.focused().workarea
    if direction == "up" then
        c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
    elseif direction == "down" then 
        c:geometry({ nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil })
    elseif direction == "left" then 
        c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
    elseif direction == "right" then 
        c:geometry({ x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil })
    end
end

-- MOVE CLIENT DWIM (Do What I Mean)
-- ==================================================================
-- Move to edge if the client / layout is floating
-- Swap by index if maximized
-- Else swap client by direction
function helpers.move_client_dwim(c, direction)
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        helpers.move_to_edge(c, direction)
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- RUN OR RAISE
-- ==================================================================
function helpers.run_or_raise(match, move, spawn_cmd, spawn_args)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    -- Find and raise
    local found = false
    for c in awful.client.iterate(matcher) do
        found = true
        c.minimized = false
        if move then
            c:move_to_tag(mouse.screen.selected_tag)
            client.focus = c
            c:raise()
        else
            c:jump_to()
        end

        -- -- Return if found
        -- return
        -- -- This would normally work, but some terminals (*cough* termite)
        -- -- create 2 instances of the same class, for just one window.
        -- -- So it is not reliable. We will use the helper variable "found"
        -- -- instead in order to determine if we have raised the window.
    end

    -- Spawn if not found
    if not found then
        awful.spawn(spawn_cmd, spawn_args)
    end
end

-- FLOAT AND RESIZE
-- ==================================================================
function helpers.float_and_resize(c, width, height)
    c.width = width
    c.height = height
    awful.placement.centered(c,{honor_workarea=true, honor_padding = true})
    awful.client.property.set(c, 'floating_geometry', c:geometry())
    c.floating = true
    c:raise()
end

return helpers