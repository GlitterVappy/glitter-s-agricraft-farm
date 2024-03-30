local c = require ("component")
local api = require("agricraft_lib")
local event = require ("event")
local tunnel = c.tunnel
local address = tunnel.getChannel()
local math = require("math")
local computer = require("computer")

function plantSense()
  local var = api.plantExists("EAST")
  if var == true then
     event.push("plantGrow")
     computer.beep(1000, 1)
    print("\n\n\nSend plantGrow")
  else
    computer.beep(300, .5)
    computer.beep(100, .5)
  end
end

print("\nstarting plantcheck - 1 beep is success and 2 beep is fail")
event.timer(25,plantSense,20000)

