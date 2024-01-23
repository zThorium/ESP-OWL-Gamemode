 -- MAXIME
 
--ATM SERVICE PED
local localPlayer = getLocalPlayer()
local atmPed = createPed( 113, 1443.2294921875, 1574.9267578125, 11.963119506836 )
setPedRotation( atmPed, 90 )
setElementDimension( atmPed, 1352)
setElementInterior( atmPed , 56 )
setElementData( atmPed, "talk", 1, false )
setElementData( atmPed, "name", "Farmacos Estado", false )
--setPedAnimation ( atmPed, "INT_OFFICE", "OFF_Sit_Bored_Loop", -1, true, false, false )
setElementFrozen(atmPed, true)


--GENERAL SERVICE PED
local localPlayer = getLocalPlayer()
local generalServicePed = createPed( 290, 1443.234375, 1571.1435546875, 11.963119506836 )
setPedRotation( generalServicePed, 89.993133)
setElementDimension( generalServicePed, 1352)
setElementInterior( generalServicePed , 56 )
setElementData( generalServicePed, "talk", 1, false )
setElementData( generalServicePed, "name", "Jonathan Smith", false )
setElementData( generalServicePed, "depositable", 1 , true )
setElementData( generalServicePed, "limit", 0 , true )
--setPedAnimation ( generalServicePed, "INT_OFFICE", "OFF_Sit_Type_Loop", -1, true, false, false )
setElementFrozen(generalServicePed, true)

--createBlip(1570.4228515625, -1337.3984375, 16.484375, 52, 2, 255, 0, 0, 255, 0, 300) -- Star tower

local wGui = nil
function bankerInteraction(ped) 
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
		return false
	end
	
	
	setElementData(getLocalPlayer(), "exclusiveGUI", true, false)
	
	local verticalPos = 0.1
	local numberOfButtons = 6*1.1
	local Width = 350
	local Height = 330
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	local option = {}
	if not (wGui) then
		showCursor(true)
		--NEW CARD
		wGui = guiCreateWindow(X, Y, Width, Height, "'Que puedo hacer por usted señor?'", false )
		option[1] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Quiero solicitar una nueva tarjeta de cajero automático, por favor.", true, wGui )
		addEventHandler( "onClientGUIClick", option[1], function()
			closeBankerInteraction()
			triggerServerEvent("bank:applyForNewATMCard", localPlayer)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
		--LOCK CARD
		option[2] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "He perdido mi tarjeta de cajero automático\nMe gustaría cerrarlo, por favor. ($0)", true, wGui )
		addEventHandler( "onClientGUIClick", option[2], function()
			closeBankerInteraction()
			triggerServerEvent("bank:lockATMCard", localPlayer)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
		--UNLOCK CARD
		option[3] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Encontré mi tarjeta de cajero automático\n ¿Podrías reactivarlo por favor? ($0)", true, wGui )
		addEventHandler( "onClientGUIClick", option[3], function()
			closeBankerInteraction()
			triggerServerEvent("bank:unlockATMCard", localPlayer)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
		--RECOVER CARD
		option[4] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Necesito recuperar mi tarjeta de cajero automático\nY si también pudieras decirme el código PIN sería genial. ($45.000)", true, wGui )
		addEventHandler( "onClientGUIClick", option[4], function()
			closeBankerInteraction()
			triggerServerEvent("bank:recoverATMCard", localPlayer)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
		--DELETE CARD
		option[5] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Quiero cancelar mi tarjeta de cajero automático\nQuiero decir que ya no lo uso ($0)", true, wGui )
		addEventHandler( "onClientGUIClick", option[5], function()
			closeBankerInteraction()
			triggerServerEvent("bank:cancelATMCard", localPlayer)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
		--CANCEL CARD
		option[6] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Ah no importa.", true, wGui )
		addEventHandler( "onClientGUIClick", option[6], function()
			closeBankerInteraction()
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
	end
end
addEvent( "bank-system:bankerInteraction", true )
addEventHandler( "bank-system:bankerInteraction", getRootElement(), bankerInteraction )

function closeBankerInteraction()
	if wGui then
		destroyElement(wGui)
		wGui = nil
	end
	showCursor(false)
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end