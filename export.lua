local log_file = nil

function LuaExportStart()


	package.path  = package.path..";"..lfs.currentdir().."/LuaSocket/?.lua"
	package.cpath = package.cpath..";"..lfs.currentdir().."/LuaSocket/?.dll"

	socket = require("socket")
	IPAddress = "127.0.0.1"
	Port = 31090

	MySocket = socket.try(socket.connect(IPAddress, Port))
	MySocket:setoption("tcp-nodelay",true) 


  log_file = io.open(lfs.writedir() .. [[Logs\Export.log]], "w")
  log_file:write(string.format("start"))

end
function LuaExportAfterNextFrame()



end
  
function LuaExportActivityNextEvent(t)

local tNext = t

-- Put your event code here and increase tNext for the next event
-- so this function will be called automatically at your custom
-- model times. 
-- If tNext == t then the activity will be terminated.

--[[
  if log_file then
		local o = LoGetWorldObjects()
			for k,v in pairs(o) do
				log_file:write(string.format("t = %.2f, ID = %d, name = %s, country = %s(%s), LatLongAlt = (%f, %f, %f), heading = %f\n", t, k, v.Name, v.Country, v.Coalition, v.LatLongAlt.Lat, v.LatLongAlt.Long, v.LatLongAlt.Alt, v.Heading))
		end
		
			tNext = tNext + 1.0
]]--	
		
		local o = LoGetWorldObjects()
			for k,v in pairs(o) do				
				socket.try(MySocket:send(string.format("ID = %d, Name = %s, Coalition = %s, Alt = %.0f, Heading = %f, Lat= %f, Long = %f \n", k, v.Name, v.Coalition, v.LatLongAlt.Alt, v.Heading, v.LatLongAlt.Lat, v.LatLongAlt.Long)))
			end
		
		
		tNext = tNext + 1.0
	
		return tNext
end

function LuaExportStop() 

  
    log_file:write(string.format("exit"))
	
	if log_file then
	log_file:close()
	log_file = nil
	end
	
	if MySocket then 
		socket.try(MySocket:send("quit")) -- to close the listener socket
		MySocket:close()
	end
end
 