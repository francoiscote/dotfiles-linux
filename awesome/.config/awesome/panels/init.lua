-- ===================================================================
-- Imports
-- ===================================================================


local awful = require('awful')
local top_panel = require('panels.top-panel')

-- ===================================================================
-- Initialization & Functionality
-- ===================================================================


-- Create a wibox for each screen and add it
screen.connect_signal("request::desktop_decoration", function(s)
  s.top_panel = top_panel(s)
end)