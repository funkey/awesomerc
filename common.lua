local wibox = require("wibox")
local awful = require("awful")
local common = {}

function common:create_progressbar()

  progressbar = awful.widget.progressbar()
  progressbar:set_width(4)
  progressbar:set_height(12)
  progressbar:set_vertical(true)
  progressbar:set_background_color(theme.color_gray)
  progressbar:set_color(theme.color_white)

  marginbox = wibox.layout.margin()
  marginbox:set_left(0)
  marginbox:set_right(0)
  marginbox:set_top(2)
  marginbox:set_bottom(2)
  marginbox:set_widget(progressbar)

  return marginbox

end

return common
