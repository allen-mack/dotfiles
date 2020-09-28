------------------------------------------------------------
-- GET FRAME
------------------------------------------------------------
local function getFrame()

  -- Get the frontmost window
  local fw = hs.window.frontmostWindow()
  local app = fw:application()

  -- If the frontmost window isn't a Mail window, then just return.
  if app:name() ~= "Mail" then
    return nil
  end

  return fw:frame()

end

------------------------------------------------------------
-- ACCEPT
------------------------------------------------------------
local function accept()

  -- Get the window frame
  local frm = getFrame()
  if frm == nil then return end

  -- Move the mouse
  local newPoint = {}
  newPoint["x"] = frm["_x"] + frm["_w"] - 50
  newPoint["y"] = frm["_y"] + 55 
  -- hs.mouse.setAbsolutePosition(newPoint)
  hs.eventtap.leftClick(newPoint)

end

------------------------------------------------------------
-- DECLINE
------------------------------------------------------------
local function decline()

  -- Get the window frame
  local frm = getFrame()
  if frm == nil then return end

  -- Move the mouse
  local newPoint = {}
  newPoint["x"] = frm["_x"] + frm["_w"] - 130
  newPoint["y"] = frm["_y"] + 55 
  -- hs.mouse.setAbsolutePosition(newPoint)
  hs.eventtap.leftClick(newPoint)

end

------------------------------------------------------------
-- MAYBE
------------------------------------------------------------
local function maybe()

  -- Get the window frame
  local frm = getFrame()
  if frm == nil then return end

  -- Move the mouse
  local newPoint = {}
  newPoint["x"] = frm["_x"] + frm["_w"] - 210
  newPoint["y"] = frm["_y"] + 55 
  -- hs.mouse.setAbsolutePosition(newPoint)
  hs.eventtap.leftClick(newPoint)
end

meetingRequest = {}
meetingRequest["accept"] = accept
meetingRequest["decline"] = decline
meetingRequest["maybe"] = maybe
