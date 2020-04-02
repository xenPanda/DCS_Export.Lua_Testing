function LuaExportStart()

local PANDA = {}

  package.path = package.path..";"..lfs.currentdir().."/LuaSocket/?.lua"
  package.cpath = package.cpath..";"..lfs.currentdir().."/LuaSocket/?.dll"

PANDA.RECEIVE_PORT = 9086
PANDA.SEND_TO_PORT = 31090



-- local socket = require("socket")
-- PANDA.UDPSendSocket = socket.udp()
-- PANDA.UDPLosReceiveSocket = socket.udp()

-- local JSON = loadfile("Scripts\\JSON.lua")()
-- PANDA.JSON = JSON

-- socket.try(PANDA.UDPSendSocket:sendto(PANDA.JSON:encode(_losList) .. " \n", "127.0.0.1", PANDA.SEND_TO_PORT))
  

  
  PANDA.logFile = io.open(lfs.writedir() .. [[Logs\PDebug.log]], "w")
  
function PANDA.log(str)
    if PANDA.logFile then
        PANDA.logFile:write(str .. "\n")
        PANDA.logFile:flush()
    end
end


  PANDA.log("Loaded Test Export.Lua version: 0.0.0.1")
  
end
function LuaExportAfterNextFrame()

  local _GeoPoint = LoGeoCoordinatesToLoCoordinates(_client.lng,_client.lat)
  PANDA.log(_GeoPoint)

local IAS = LoGetIndicatedAirSpeed()


end
  
function LuaExportActivityNextEvent()

end

function LuaExportStop() 
  if PANDA.UDPSendSocket then
    PANDA.UDPSendSocket:close()
  end
end
  