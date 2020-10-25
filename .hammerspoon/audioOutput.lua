------------------------------------------------------------
-- CLICKCONNECT
-- Open Pulse Secure and click on the button at the offset.
------------------------------------------------------------
local function selectAudioOutput()

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

end

------------------------------------------------------------
-- Place the callable functions into an exported table.
------------------------------------------------------------
audioOutput = {}
audioOutput ["selectAudioOutput"] = selectAudioOutput
