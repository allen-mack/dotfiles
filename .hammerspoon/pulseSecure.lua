------------------------------------------------------------
-- Y Offsets 
-- How far down from the top of the window to the 
-- corresponding button.
------------------------------------------------------------
local yOffsets = {
  ["USA_Atlanta"] = 95, 
  ["USA_Atlanta TWD"] = 150,
  ["USA_East Coast"] = 215,
  ["USA_West Coast"] = 270,
}

------------------------------------------------------------
-- SLEEP
-- Pause execution for n seconds.
------------------------------------------------------------
local function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

------------------------------------------------------------
-- CLICKCONNECT
-- Open Pulse Secure and click on the button at the offset.
------------------------------------------------------------
local function clickConnect(yOffset)
  local ps = hs.application.open("Pulse Secure")
  -- sleep(0.5)
  sleep(1)
  ps:setFrontmost()

  local fw = ps:focusedWindow()
  hs.alert(fw)
  local frm = fw:frame()

  -- Move the mouse
  local newPoint = {}
  newPoint["x"] = frm["_x"] + frm["_w"] - 100
  newPoint["y"] = frm["_y"] + yOffset 
  -- hs.mouse.setAbsolutePosition(newPoint)
  hs.eventtap.leftClick(newPoint)

  -- Killing the application will leave the login window.
  sleep(0.5)
  ps:kill()
end

------------------------------------------------------------
-- CONNECT
-- Initiate connection to the default profile (USA_Atlanta)
------------------------------------------------------------
local function connect()
  hs.alert(yOffsets["USA_Atlanta"])
  clickConnect(yOffsets["USA_Atlanta"])
end

------------------------------------------------------------
-- SELECTCONNECT
-- Give the user a list of profiles to select from based on
-- the yOffsets table.
------------------------------------------------------------
local function selectConnect()
  local choices = {}

  for k in pairs(yOffsets) do
    local c = {
      ["text"] = k
    }

    table.insert(choices, c)
  end

  -- Create a new chooser object
  local chooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end

    clickConnect(yOffsets[choice["text"]])
  end)

  chooser:rows(#choices)

  chooser:queryChangedCallback(function(string)
    chooser:choices(choices)
  end)

  chooser:searchSubText(true)

  chooser:width(20)

  chooser:show()
end

------------------------------------------------------------
-- Place the callable functions into an exported table.
------------------------------------------------------------
pulseSecure = {}
pulseSecure["connect"] = connect
pulseSecure["selectConnect"] = selectConnect
