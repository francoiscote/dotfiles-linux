-- ===================================================================
-- Imports
-- ===================================================================

-- local dir = os.getenv('HOME') .. '/.config/awesome/icons/tags/'
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")


-- ===================================================================
-- Define tags
-- ===================================================================
local l = awful.layout.suit

local tags = {
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Editor",
    layout              = l.tile,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.7,
    gap_single_client   = true,
    screen              = s
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Browser",
    layout              = l.tile,
    master_fill_policy  = "ma2ster_width_factor",
    master_width_factor = 0.7,
    gap_single_client   = true,
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Three",
    layout              = l.floating,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Emails",
    layout              = l.tile,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
    gap                 = 50
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Five",
    layout              = l.floating,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Six",
    layout              = l.floating,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Chat",
    layout              = l.tile,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
    gap                 = 30
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Music",
    layout              = l.floating,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
  },
  {
    -- icon = dir .. 'terminal.png',
    -- type = 'terminal',
    -- defaultApp = apps.terminal,
    -- name                = "Other",
    layout              = l.floating,
    master_fill_policy  = "master_width_factor",
    master_width_factor = 0.5,
    gap_single_client   = true,
  }
}


-- ===================================================================
-- Additional Setup
-- ===================================================================


-- define tag layouts
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.max,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- apply tag settings to each tag
screen.connect_signal("request::desktop_decoration", function(s)
  for i, tag in pairs(tags) do
    awful.tag.add(i, gears.table.join({
      index = i,
      selected = i == 1,
      screen = s
    }, tag))
  end
end)

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
  local currentLayout = awful.tag.getproperty(t, 'layout')
  if (currentLayout == awful.layout.suit.max) then
    t.gap = 0
  else
    t.gap = beautiful.useless_gap
  end
end)