
--by glittervappy

---------------------------------------------
-- this file's purpose is to simplify and
-- have proper OC support for Agricraft 1.12.2
---------------------------------------------


--import libraries

component = require("component")
sides = require("sides")

cagr = component.agricraft_peripheral 
ctun = component.tunnel

--TIL than you need to return these at the end
-- to allow calling stuff like agricraft_lib.canGrow and shit.
local lib={}


-- define functions


-- becuz robut
function lib.getChannel()
  
  local var = ctun.getChannel()
  return var    

end

-->>>>>>>>>>>>>>

--This is for debugging. because i use it.
--insert into code for fun

local debugcount = 0
function lib.debugincrement(printable, reason)
debugcount = debugcount+1
lib.debug(printable, reason)
end

function lib.debug(printable, reason)
 print("\n-----------DEBUG IS ON-----------")
 print("\nDEBUG CYCLE:" , debugcount)
 print("VALUE:", printable)
 print("TYPE", type(printable))
 print("REASON", reason)
 print("\n-----------END DEBUGGING------------\n")
end

-->>>>>>>>>>>>>>>



--This block of code is for direction converting. it is called way too much lol
-- might make it its own file but its easier to edit everything in one file..

-- turns OC directions into agricraft ones
-- i figured i would add some input validation...
-- but i dont want a billion if statements
-- so if youre getting an error about 
-- EnumError or something, check your inputs.

function lib.convertDirectionStep1(value)
   if type(value) == "string" then
    return(value)

  elseif value == 2 then
    return ("NORTH")

  elseif value == 3 then
    return ("SOUTH")

  elseif value == 4 then
    return ("WEST")

  elseif value == 5 then
    return("EAST")

  else
    return(100) end
end


-- i chose north because its a nice reference
-- feel free to change.
function lib.convertDirection(value)
  local process = lib.convertDirectionStep1(value)
  if process == 100 then
    print("ERROR: side has defaulted to cardinal north due to improper input")  
    return("NORTH")
    
   else
    return(process)
  end

end

-->>>>>>>>>>>>>

--this block of code basically calls all the stats you could possibly want


--hasPlant, but dirconverted
function lib.plantExists(direction)
  local out = cagr.hasPlant(lib.convertDirection(direction))
  return out
end

--getBrightness but dirconverted
function lib.lightLevel(direction)
  local out = cagr.getBrightness(lib.convertDirection(direction))
  return out
end

--getBrightnessRange but better
function lib.lightLevelNeeded(direction)
  local out = cagr.getBrightnessRange(lib.convertDirection(direction))
  return out
end

--getPlant, but better
function lib.plantType(direction)
  local out = cagr.getPlant(lib.convertDirection(direction))
  return out
end

--isFertile, but better
function lib.canGrow(direction)
  local out = cagr.isFertile(lib.convertDirection(direction))
  return out
end

--statsKnown
--fuck you, no more for rn


--aggregates all the main plant info you would need in a program
-- if you need more, idk code it yourself lol
-- order: hasPlant, plantType, getBrightness, isFertile, getBrightnessRange

function lib.plantInfo(direction)
  local cDir = lib.convertDirection(direction)
  local cropBool = lib.plantExists(cDir)
  local cropType = lib.plantType(cDir)
  local lightNum = lib.lightLevel(cDir)
  local growing = lib.canGrow(cDir)
  local lightNeeded = lib.lightLevelNeeded(cDir)

  return cropBool, cropType, lightNum, growing, lightNeeded
end

return lib
-->>>>>>>>>>>>>>>>>