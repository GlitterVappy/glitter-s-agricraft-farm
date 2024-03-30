local component = require("component")
local robot = component.tunnel

local x = robot.getWakeMessage()
print(x)

local y = robot.setWakeMessage("robotWake")
print(y)