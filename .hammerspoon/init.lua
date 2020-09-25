--[[
-- Hotkey Bindings
]]--

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  -- hs.alert.show("Hello World!")
  hs.notify.new({title="Hammerspoon", informativeText="Hello Allen!"}):send()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  success, obj, desc = hs.osascript.applescriptFromFile(os.getenv("HOME") .. "/.hammerspoon/clearNotifications.applescript")
end)

--[[
-- ShiftIt Spoon - https://github.com/peterklijn/hammerspoon-shiftit
-- ]]
hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({
  center = {{ 'ctrl', 'alt', 'cmd' }, 'j' },
})

--[[
-- Dynamic reloading of the config file.
]]--

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
