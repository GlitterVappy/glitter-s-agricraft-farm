local api = require("glitterapi")
local r = component.robot
local sides = require("sides")

event.timer(.5,api.posTracker(),3)