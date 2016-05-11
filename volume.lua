local wibox = require("wibox")
local awful = require("awful")
local vicious = require("vicious")
local helpers = require("./helpers")
local common = require("./common")

-- widget settings
alsa_channel = "Master"
alsa_step = "5%"
alsa_mixer = terminal .. " -e alsamixer"

-- create the widget
local widget = {}
widget.icon = wibox.widget.imagebox()
widget.bar = common:create_progressbar()
widget.bar_tip = awful.tooltip({ objects = { widget.bar }})

-- set mouse bindings
bindings = awful.util.table.join(

    awful.button({ }, 1, function()
        awful.util.spawn(alsa_mixer)
    end),

    awful.button({ }, 3, function()
      widget:mute()
    end),

    awful.button({ }, 4, function()
      widget:raise()
    end),

    awful.button({ }, 5, function()
      widget:lower()
    end)
)
widget.icon:buttons(bindings)
widget.bar:buttons(bindings)

-- register bar with vicious, update tip and icon in passing
vicious.register(widget.bar.widget, vicious.widgets.volume, function (bar, args)

    local volume = args[1]

    if args[2] == "♩" then

        widget.bar_tip:set_text(" [Muted] ")
        state = "muted"
        volume = 0

    else

      widget.bar_tip:set_text(" " .. alsa_channel .. ": " .. volume .. "% ")

      if volume == 0 then
          state = "low-zero"
      elseif volume < 25 then
          state = "low"
      elseif volume > 75 then
          state = "high"
      else
          state = "medium"
      end

    end

    widget.icon:set_image(theme.icons .. "status/audio-volume-" .. state .. "-panel.svg")

    return volume

end, 5, alsa_channel) -- updated every 5 seconds, but use of keys/mouse will force update

function widget:raise()

    awful.util.spawn("amixer sset " .. alsa_channel .. " " .. alsa_step .. "+")
    helpers:delay(function() vicious.force({ widget.bar.widget }) end, 0.1)
end

function widget:lower()

    awful.util.spawn("amixer sset " .. alsa_channel .. " " .. alsa_step .. "-")
    helpers:delay(function() vicious.force({ widget.bar.widget }) end, 0.1)
end

function widget:mute()

    awful.util.spawn("amixer -D pulse sset " .. alsa_channel .. " toggle")
    helpers:delay(function() vicious.force({ widget.bar.widget }) end, 0.1)
end

return widget
