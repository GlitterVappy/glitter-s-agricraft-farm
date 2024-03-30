local c = require("component")
local t = c.tunnel
local event = require("event")
local agr = c.agricraft_peripheral

local function linkHandler(a,b,c,d,e,f)
  if f == "seedIn" then
    agr.analyze()
    print("analyzing seed.")
    os.sleep(5)
    local x,y,z = agr.getSpecimenStats()
    if x == y and z and 10 then
      print("done!")
      t.send("getNewSeed")
    else 
      print("restarting..")
      t.send("restart")
    end
  else end
    main()
    return f
end

local function main()
  event.listen("modem_message", linkHandler)
end
main()