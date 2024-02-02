local streamURL = "http://15.stmip.in:28058"
function onResourceStart()
	
sound = playSound3D(streamURL, 1856.17847, -1790.58618, 14.64063, true) 

end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart)
