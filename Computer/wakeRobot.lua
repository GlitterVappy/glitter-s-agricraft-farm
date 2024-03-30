local component = require("component")
local event = require("event")
local link = component.tunnel

function run()
  link.send("robotWake")
  os.sleep(3)
  link.send("startRobot")
end

event.listen("plantGrow", run)