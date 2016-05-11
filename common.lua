local wibox = require("wibox")
local awful = require("awful")
local common = {}

function common:create_progressbar()

  local margin = theme.wibox_height*0.15
  local height = theme.wibox_height - 2*margin
  local width  = 0.2*height

  progressbar = awful.widget.progressbar()
  progressbar:set_width(width)
  progressbar:set_height(height)
  progressbar:set_vertical(true)
  progressbar:set_background_color(theme.color_gray)
  progressbar:set_color(theme.color_white)

  marginbox = wibox.layout.margin()
  marginbox:set_left(0)
  marginbox:set_right(0)
  marginbox:set_top(margin)
  marginbox:set_bottom(margin)
  marginbox:set_widget(progressbar)

  return marginbox

end

return common
