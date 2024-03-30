local component = require("component")
local robot = component.robot
local event = require("event")
local computer = require("computer")
local note = require("note")
local lib = require("glitterapi")

local function runStart(x,y,z,a,b)
  
  note.play("G4",.01)
  note.play("E4",.01)
  note.play("E5",.05)
  lib.doNow()
  
end

local function linkHandler(a,b,c,d,e,f)
  if f == "testString" then
    print(f)
  elseif f == "startRobot" then
    event.push("startRobot")
  elseif f == "getNewSeed" then
    event.push("getNewSeed")
  elseif f == "restart" then
    event.push("newCycle")
  elseif f == "shutdown" then
    print("figure out how to remote shutdown dummy")
  else end
end

local function newCycle()
  lib.newCycle()
end

local function newSeed()
  lib.restart()
end

event.listen("getNewSeed", newSeed)
event.listen("newCycle",newCycle)
event.listen("startRobot",runStart)
event.listen("modem_message",linkHandler)