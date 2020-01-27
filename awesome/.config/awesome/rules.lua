
local awful = require('awful')
local beautiful = require("beautiful")
local keys = require("keys")

local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width

-- RULES
-- ==================================================================
-- Rules to apply to new clients (through the "manage" signal).
rules = {
    -- All Clients will match this rule
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            screen = awful.screen.preferred,
            screen = awful.screen.focused,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            placement = awful.placement.centered
        },
        callback = function (c)
            if not awesome.startup then
                -- If the layout is floating or there are no other visible clients
                -- Apply placement function
                if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
                    awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
                else
                    client_placement_f(c, {honor_padding = true, honor_workarea=true, margins = beautiful.useless_gap * 2})
                end

                -- Hide titlebars if required by the theme
                if not beautiful.titlebars_enabled then
                    decorations.hide(c)
                end

            end
        end
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
          "floating_terminal",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "pritunl",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Lxappearance",
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "GtkFileChooserDialog",
          "conversation",
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

     -- Centered clients
     {
        rule_any = {
            type = {
                "dialog",
            },
            class = {
                "Steam",
                "discord",
            },
            role = {
                "GtkFileChooserDialog",
                "conversation",
            }
        },
        properties = {},
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    -- Fixed terminal geometry
    {
        rule_any = {
            class = {
                "Alacritty",
                "Termite",
                "mpvtube",
                "kitty",
                "st-256color",
                "st",
                "URxvt",
            },
        },
        properties = { width = screen_width * 0.45, height = screen_height * 0.5 }
    },

    -- "Switch to tag"
    -- These clients make you switch to their tag when they appear
    {
        rule_any = {
            class = {
                "firefoxdeveloperedition",
                "Google-chrome",
                "qutebrowser",
            },
        },
        properties = { switchtotag = true }
    },

    -- Titlebars OFF (explicitly)
    -- Titlebars of these clients will be hidden regardless of the theme setting
    {
        rule_any = {
            class = {
                "qutebrowser",
                "firefoxdeveloperedition",
                "Google-chrome",
                "Spotify"
            },
        },
        properties = {},
        callback = function (c)
            if not beautiful.titlebars_imitate_borders then
                decorations.hide(c)
            end
        end
    },

    -- Titlebars ON (explicitly)
    -- Titlebars of these clients will be shown regardless of the theme setting
    -- {
    --     rule_any = {
    --         class = {
    --             --"???",
    --         },
    --         type = {
    --             "dialog",
    --         },
    --         role = {
    --             "conversation",
    --         }
    --     },
    --     properties = {},
    --     callback = function (c)
    --         decorations.show(c)
    --     end
    -- },
    
    -- Skip taskbar
    {
        rule_any = {
            class = {
                --"feh",
            },
        },
        properties = { skip_taskbar = true }
    },

    -- File chooser dialog
    {
        rule_any = { role = { "GtkFileChooserDialog" } },
        properties = { floating = true, width = 900, height = 600 }
    },

    -- Pavucontrol
    {
        rule_any = { class = { "Pavucontrol" }, name = { "Bluetooth Devices" }  },
        properties = { floating = true, width = screen_width * 0.45, height = screen_height * 0.8 }
    },

    -- Galculator
    {
        rule_any = { class = { "Galculator" } },
        except_any = { type = { "dialog" } },
        properties = { floating = true, width = screen_width * 0.2, height = screen_height * 0.4 }
    },

    -- File managers
    {
        rule_any = {
            class = {
                "Nemo",
                "Thunar"
            },
        },
        except_any = {
            type = { "dialog" }
        },
        properties = { floating = true, width = screen_width * 0.45, height = screen_height * 0.55}
    },

    -- Music clients
    {
        rule_any = {
            class = {
                "Spotify",
            }
        },
        properties = {
            floating = true,
            width = screen_width * 0.6,
            height = screen_width * 0.6 * 0.6
        },
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    -- Image viewers
    {
        rule_any = {
            class = {
                "feh",
                "Sxiv",
            },
        },
        properties = {
            floating = true,
            width = screen_width * 0.7,
            height = screen_height * 0.75
        },
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    ---------------------------------------------
    -- Start application on specific workspace --
    ---------------------------------------------
    -- Editors
    {
        rule_any = {
            class = {
                "Code",
            },
        },
        properties = { screen = 1, tag = "1"},
    },

    -- Browsing
    {
        rule_any = {
            class = {
                "Firefox",
                "qutebrowser",
                "Google-chrome"
            },
        },
        except_any = {
            role = { "GtkFileChooserDialog" },
            type = { "dialog" }
        },
        properties = { screen = 1, tag = "2" },
    },

    -- Main Terminal (Tags 1 and 2)
    {
        rule_any = {
            instance = {
                "main-terminal",
            },
        },
        properties = { 
            screen = 1,  
            tags = {"1", "2"}
        }
    },

    -- Zoom (tags 1 and 2)
    {
        rule_any = {
            class = {
                "zoom"
            },
        },
        properties = { 
            screen = 1,  
            tags = {"1", "2"}
        }
    },

    -- Chatting
    {
        rule_any = {
            class = {
                "discord",
                "TelegramDesktop",
                "Signal",
                "Slack",
                "Franz",
                "TeamSpeak 3",
            },
        },
        properties = { screen = 1, tag = "7" }
    },

    -- Music
    {
        rule_any = {
            class = {
                "Spotify",
            },
        },
        properties = { screen = 1, tag = "8" }
    },

    -- Miscellaneous
    -- All clients that I want out of my way when they are running
    {
        rule_any = {
            class = {
                "Pritunl",
            },
        },
        properties = { screen = 1, tag = "9" }
    },
}

return rules