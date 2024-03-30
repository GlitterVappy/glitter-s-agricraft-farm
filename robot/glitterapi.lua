local c = require("component")
local robot = require("robot")
local inv = c.inventory_controller
local r = c.robot
local event = require("event")
local api = {}
local sides = require("sides")
local tunnel = c.tunnel
local computer = require("computer")
function api.moveRight()
  print("\n moving right.")
  robot.turnRight()
  robot.forward()
  robot.turnLeft()
end

function api.moveLeft()
  print("\n moving left.")
  robot.turnLeft()
  robot.forward()
  robot.turnRight()
end

function api.doNow()

  --first, break everything, but last
  api.breakJunk()

  --then, void items.
  robot.turnAround()
  
   api.void()

  --then, break last, and put inside of analyzer. 
  api.sample()

  --then, void items.
  robot.turnAround()
  api.void()

  --then, grab new sticks(7)
  api.getSticks()

  --then, place sticks. 
  api.placeSticks()

  --rest is handled by startup daemon
end

function api.breakJunk()
 -- break all but last
 -- 0 0 0 x
  print("\nbreakjunk...")
  local pos = 0
  while pos <3 do
    robot.swing(sides.front)
    api.moveRight()
    pos = pos+1
  end
end

function api.void()
  print("\nvoiding items...")
  for x = 1,16 do
    robot.select(x)
    robot.drop()
  end
  robot.select(1)
end

function api.sample()
  print("depositing sample")
  robot.turnAround()
  robot.swing(sides.front)
  api.moveRight()
  api.void()
  tunnel.send("seedIn")
end

function api.getSticks()
  print("getting sticks...")
  robot.turnLeft()
  robot.suck(7)
  robot.turnLeft()
  local x =  0
  while x <=3 do
    api.moveLeft()
    x = x+1
  end
  inv.equip()
end

function api.placeSticks()
 --  / x x x 8
  print("placing sticks...")
  local pos = 0
  while pos <4 do
    if pos == 0 then
      print("first")      
      r.use(sides.front)
      os.sleep(.1)
      api.moveRight()
      pos = pos+1

    else
      r.use(sides.front)
      r.use(sides.front)
      api.moveRight()
      pos = pos+1
      end
  end

end

function api.restart() 
  robot.suck(1)
  local x = 0
  while x <4 do
    api.moveLeft()
    x = x+1
  end
  robot.turnAround()
  api.void()
  robot.turnRight()
  robot.suck()
  inv.equip()
  robot.turnRight()
  r.use(sides.front)
  print("done")
  computer.beep(330,0.2)
  computer.beep(100,0.2)
  computer.shutdown()  
end

function api.newCycle()
  robot.suck(1)
  inv.equip()
  local x = 0
  while x < 4 do
  api.moveLeft()
  x=x+1
  end
  r.use(sides.front)
  computer.beep(330,0.2)
  computer.beep(100, 0.2)
  computer.shutdown()
end
return api