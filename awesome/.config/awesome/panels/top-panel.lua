-- ===================================================================
-- Imports
-- ===================================================================
local awful = require('awful')
local wibox = require("wibox")
local beautiful = require('beautiful')
local gears = require('gears')
local helpers = require('helpers')
local dpi = require('beautiful').xresources.apply_dpi


-- ===================================================================
-- Bar Widget Creation
-- ===================================================================
local mymainmenu = require('widgets.main-menu')
mylauncher = awful.widget.launcher({ 
  image = beautiful.awesome_icon,
  menu = mymainmenu 
})

-- Clock / Calendar 12h format
-- Get Time/Date format using `man strftime`
local textclock = wibox.widget.textclock('<span font="' .. beautiful.title_font ..'">%l:%M %p</span>', 1)

-- Clock / Calendar 12AM/PM fornatan font="Roboto Mono bold 11">%I\n%M</span>\n<span font="Roboto Mono bold 9">%p</span>')
local clock_widget = wibox.container.margin(textclock, dpi(0), dpi(0), dpi(0), dpi(0))

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {textclock},
    mode = 'outside',
    preferred_positions = {'bottom', 'right', 'left', 'top'},
    preferred_alignments = {'middle', 'front', 'back'},
    timer_function = function()
      return os.date("The date today is %B %d, %Y. And it's fucking %A!")
    end,
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8)
  }
)

local cal_shape = function(cr, width, height)
  gears.shape.partially_rounded_rect(
    cr, width, height, false, false, true, true, 12)
end

-- Calendar Widget
local month_calendar = awful.widget.calendar_popup.month({
	start_sunday = true,
	spacing = 10,
	font = beautiful.title_font,
	long_weekdays = true,
	margin = 0, -- 10
	style_month = { border_width = 0, padding = 12, shape = cal_shape, padding = 25},
	style_header = { border_width = 0, bg_color = '#00000000'},
	style_weekday = { border_width = 0, bg_color = '#00000000'},
	style_normal = { border_width = 0, bg_color = '#00000000'},
	style_focus = { border_width = 0, bg_color = '#82b3e2'},
})

-- Attach calentar to clock_widget
month_calendar:attach(clock_widget, "tc" , { on_pressed = true, on_hover = false })

-- Systray widget
-- Create to each screen
screen.connect_signal("request::desktop_decoration", function(s)
  s.systray = wibox.widget.systray()
  s.systray.visible = false
  s.systray:set_horizontal(true)
  s.systray:set_base_size(26)
  s.systray.opacity = 0.3
end)

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Execute only if system tray widget is not loaded
awesome.connect_signal("toggle_tray", function()
  if not require('widgets.systemtray') then
    if awful.screen.focused().systray.visible ~= true then
      awful.screen.focused().systray.visible = true
    else
      awful.screen.focused().systray.visible = false
    end
  end
end)

local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button(
    { modkey }, 1, 
    function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end
  ),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button(
    { modkey }, 3, 
    function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end
  ),
  awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
                          if c == client.focus then
                              c.minimized = true
                          else
                              c:emit_signal(
                                  "request::activate",
                                  "tasklist",
                                  {raise = true}
                              )
                          end
                      end),
  awful.button({ }, 3, function()
                          awful.menu.client_list({ theme = { width = 250 } })
                      end),
  awful.button({ }, 4, function ()
                          awful.client.focus.byidx(1)
                      end),
  awful.button({ }, 5, function ()
                          awful.client.focus.byidx(-1)
                      end)
)

-- ===================================================================
-- Bar Creation
-- ===================================================================
local TopPanel = function(s)

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  local mylayoutbox = awful.widget.layoutbox(s)
  mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  local mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.noempty,
      layout  = {
        layout  = wibox.layout.fixed.horizontal
      },
      widget_template = {
        id = "my_bg",
        widget = wibox.container.background,
        shape  = helpers.rrect(6),
        forced_width = 40,
        {
          id = 'background_role',
          widget = wibox.container.background,
          forced_width = 100 / 9,
          bg = '#1a1823',
          {
            widget = wibox.container.place,
            {
              id = "text_role",
              font = "Google Sans 12",
              widget = wibox.widget.textbox,
            }
          },
        },
        -- Add support for hover colors and an index label
        create_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id("text_role")[1].markup = '<b> '..index..' </b>'
            self:connect_signal('mouse::enter', function()
                if self.bg ~= '#00000000' then
                    self.backup_bg     = '#00000000'
                    self.backup_fg     = '#ffffffff'
                end
                self.bg = beautiful.xcolor8
                self.fg = beautiful.xforeground
            end)
            self:connect_signal('mouse::leave', function()
                if self.backup_bg then 
                    self.bg = self.backup_bg
                    self.fg = self.backup_fg
                end
            end)
        end,
        update_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id("text_role")[1].markup = '<b> '..index..' </b>'
        end,
      },
      buttons = taglist_buttons
  }

  -- Create a tasklist widget
  local mytasklist = awful.widget.tasklist {
      screen  = s,
      filter  = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons
}

  local panel = awful.wibar({ position = "top", screen = s })

  -- define space to push windows away (equal to bar length so windows dont cover panel)
  panel:struts({
    top = dpi(26)
  })

  panel:setup {
    expand = "none",
    layout = wibox.layout.align.horizontal,
    -- Left widgets
    { 
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        mytaglist,
        -- mytasklist,
    },
    -- Middle widget
    clock_widget,
    -- Right widgets
    { 
      layout = wibox.layout.fixed.horizontal,
      s.systray,
      require('widgets.systemtray'),
      mykeyboardlayout,
      mylayoutbox,
    },
  }

  return panel
end

return TopPanel