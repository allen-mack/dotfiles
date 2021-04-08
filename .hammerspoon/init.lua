------------------------------------------------------------
-- Require
------------------------------------------------------------

require 'audioOutput'
require 'citrix'
require 'meetingRequest'
require 'pulseSecure'

------------------------------------------------------------
-- Hotkey Bindings
------------------------------------------------------------

-- f6 -> Select Citrix Application
hs.hotkey.bind({}, "f6", function()
  citrix.selectCitrixApp()
end)

-- f10 -> Select the audio output device.
hs.hotkey.bind({}, "f10", function()
  audioOutput.selectAudioOutput()
end)

-- f12 -> Connect to pulse secure Atlanta profile.
hs.hotkey.bind({}, "f12", function() 
  pulseSecure.connect()
end)

-- SHFT f12 -> Connect to pulse secure via menu.
hs.hotkey.bind({"shift"}, "f12", function() 
  pulseSecure.selectConnect()
end)

-- CMD ALT CRTL A - Accept Meeting Request
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "A", function()
  meetingRequest.accept()
end)

-- CMD ALT CTRL C - Clear Notifications
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  success, obj, desc = hs.osascript.applescriptFromFile(os.getenv("HOME") .. "/.hammerspoon/scripts/clearNotifications.applescript")
end)

-- CMD ALT CRTL D - Decline Meeting Request
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
  meetingRequest.decline()
end)

-- CMD ALT CRTL M - Maybe Meeting Request
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  meetingRequest.maybe()
end)

-- CMD ALT CTRL W - Hello World Notification
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  -- hs.alert.show("Hello World!")
  hs.notify.new({title="Hammerspoon", informativeText="Hello World!"}):send()
end)

------------------------------------------------------------
-- ShiftIt Spoon 
-- https://github.com/peterklijn/hammerspoon-shiftit
------------------------------------------------------------
hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({
  center = {{ 'ctrl', 'alt', 'cmd' }, 'j' },
})

------------------------------------------------------------
-- Dynamic reloading of the config file.
------------------------------------------------------------

function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon Config Loaded")
