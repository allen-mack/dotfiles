------------------------------------------------------------
-- Hotkey Bindings
------------------------------------------------------------

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  -- hs.alert.show("Hello World!")
  hs.notify.new({title="Hammerspoon", informativeText="Hello Allen!"}):send()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  success, obj, desc = hs.osascript.applescriptFromFile(os.getenv("HOME") .. "/.hammerspoon/scripts/clearNotifications.applescript")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "O", function()

  -- Get all available output audio devices and then determine the current output device.
  local outputDevices = hs.audiodevice.allOutputDevices()
  local current = hs.audiodevice.current()
  
  -- Build the choices array
  local choices = {}
  for _, dev in pairs(outputDevices) do
    local c = {
      ["text"] = dev:name()
    }

    if dev:name() == current.name then
      c["subText"] = "current selection"
    end

    table.insert(choices, c)
  end

  -- Create a new chooser object
  local chooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end

    -- If the user chooses the current device, then we don't have to do anything.
    if choice["subText"] == "current selection" then
      return
    end

    -- Set the output device
    local nextDevice = hs.audiodevice.findOutputByName(choice["text"])
    nextDevice:setDefaultOutputDevice()
  end)

  chooser:rows(#choices)

  chooser:queryChangedCallback(function(string)
    chooser:choices(choices)
  end)

  chooser:searchSubText(true)

  chooser:show()
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
