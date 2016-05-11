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

function common:create_horizontal_separator(width)

  space = wibox.widget.textbox()
  space:set_text(" ")

  marginbox = wibox.layout.margin()
  marginbox:set_left(0)
  marginbox:set_right(width)
  marginbox:set_top(0)
  marginbox:set_bottom(0)
  marginbox:set_widget(space)

  return marginbox

end

return common
