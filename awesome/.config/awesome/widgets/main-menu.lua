local awful = require('awful')
local beautiful = require('beautiful')

MyAwesomeMenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

MyMainMenu = awful.menu({ 
  items = { 
    { "awesome", MyAwesomeMenu, beautiful.awesome_icon },
    { "open terminal", user.terminal }
  }
})

return MyMainMenu