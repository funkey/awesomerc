local awful = require("awful")

function run_once(cmd, findme)
  if not findme then
    findme = cmd
    firstspace = cmd:find(" ")
    name_end = 16
    if firstspace then
      name_end = math.min(name_end, firstspace)
    end
    findme = cmd:sub(0, name_end-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- keyboard configuration
awful.util.spawn_with_shell("$HOME/local/bin/setup_inputs.sh")

-- network manager
run_once("nm-applet &")

-- we just need it to properly set the icon theme to the nice ubuntu-mono-dark
run_once("gnome-settings-daemon &")

-- be quiet
run_once("sudo thinkfan -b 1")

-- automount
run_once("$HOME/local/bin/devmon &")

--awful.util.spawn_with_shell("pkill gnome-keyring; eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh); export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK")
