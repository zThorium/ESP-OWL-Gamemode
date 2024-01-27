local rosie = createPed(141, -1347.033203125, -188.302734375, 14.151561737061)
local lsesOptionMenu = nil
setPedRotation(rosie, 296.709533)
setElementFrozen(rosie, true)
setElementDimension(rosie, 9)
setElementInterior(rosie, 6)
--setPedAnimation(rosie, "INT_OFFICE", "OFF_Sit_Idle_Loop", -1, true, false, false)
setElementData(rosie, "talk", 1, false)
setElementData(rosie, "name", "Rosie Jenkins", false)
--[[
local jacob = createPed(277, -1794.3291015625, 647.0517578125, 960.38513183594)
local lsesOptionMenu = nil
setPedRotation(jacob, 57)
setElementFrozen(jacob, true)
setElementDimension(jacob, 8)
setElementInterior(jacob, 1)
setElementData(jacob, "talk", 1, false)
setElementData(jacob, "name", "Jacob Greenaway", false)]]

function popupSFESPedMenu()
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if not lsesOptionMenu then
		local width, height = 150, 100
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		lsesOptionMenu = guiCreateWindow(x, y, width, height, "Como podemos ayudarte?", false)

		bPhotos = guiCreateButton(0.05, 0.2, 0.87, 0.2, "Necesito ayuda", true, lsesOptionMenu)
		addEventHandler("onClientGUIClick", bPhotos, helpButtonFunction, false)

		bAdvert = guiCreateButton(0.05, 0.5, 0.87, 0.2, "Cita", true, lsesOptionMenu)
		addEventHandler("onClientGUIClick", bAdvert, appointmentButtonFunction, false)
		
		bSomethingElse = guiCreateButton(0.05, 0.8, 0.87, 0.2, "Estoy bien gracias.", true, lsesOptionMenu)
		addEventHandler("onClientGUIClick", bSomethingElse, otherButtonFunction, false)
		triggerServerEvent("lses:ped:start", getLocalPlayer(), getElementData(rosie, "name"))
		showCursor(true)
	end
end
addEvent("lses:popupPedMenu", true)
addEventHandler("lses:popupPedMenu", getRootElement(), popupSFESPedMenu)

function closeSFESPedMenu()
	destroyElement(lsesOptionMenu)
	lsesOptionMenu = nil
	showCursor(false)
end

function helpButtonFunction()
	closeSFESPedMenu()
	triggerServerEvent("lses:ped:help", getLocalPlayer(), getElementData(rosie, "name"))
end

function appointmentButtonFunction()
	closeSFESPedMenu()
	triggerServerEvent("lses:ped:appointment", getLocalPlayer(), getElementData(rosie, "name"))
end

function otherButtonFunction()
	closeSFESPedMenu()
end


local pedDialogWindow
local thePed
function pedDialog_hospital(ped)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	thePed = ped
	local width, height = 500, 345
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	if pedDialogWindow and isElement(pedDialogWindow) then
		destroyElement(pedDialogWindow)
	end
	pedDialogWindow = guiCreateWindow(x, y, width, height, "Recepción del hospital", false)

	b1 = guiCreateButton(10, 30, width-20, 40, "¡Necesito un doctor ahora, alguien se está muriendo!", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b1,
		function()
			endDialog()
			if thePed then
				triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Estamos enviando un equipo aquí lo antes posible, mantenga la calma..")
				setTimer(function()
						triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "hospitalpa", "Código crítico en recepción, Código crítico en recepción, equipo de respuesta a recepción lo antes posible.")
					end, 3000, 1)
			end
		end, false)

	b2 = guiCreateButton(10, 75, width-20, 40, "Necesito que alguien me ayude o un amigo a Emergencias.", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b2,
		function()
			endDialog()
			if thePed then
				triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Estamos enviando a alguien aquí para ayudarle, por favor mantenga la calma..")
				setTimer(function()
						triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "hospitalpa", "Miembro del personal de recepción por favor para ayudar a un paciente a E.R.")
					end, 4000, 1)
			end
		end, false)

	b3 = guiCreateButton(10, 120, width-20, 40, "Estoy aquí para programar una cita o un chequeo.", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b3,
		function()
			endDialog()
			if thePed then
				triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Bien, enviaré a alguien abajo.")
				setTimer(function()
						triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "hospitalpa", "Un miembro del personal de la recepción ayuda a un paciente a realizar un chequeo o una cita.")
					end, 5000, 1)
			end
		end, false)

	b4 = guiCreateButton(10, 165, width-20, 40, "Estoy aquí para ver a un amigo que se queda en el hospital durante un período prolongado..", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b4,
		function()
			endDialog()
			if thePed then
				triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Diríjase a la sala de Servicios para pacientes hospitalizados, al final del pasillo y al primer ascensor a la izquierda. Una enfermera estará allí para ayudarle..")
			end
		end, false)

	b5 = guiCreateButton(10, 210, width-20, 40, "Estoy aquí para ver a un amigo que está en la Sala de Emergencias o en Servicios Ambulatorios.", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b5,
		function()
			endDialog()
			if thePed then
				triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Voy a enviar a un miembro del personal para que lo ayude. Tenga en cuenta que tenemos una política de 1 visitante en urgencias.")
				setTimer(function()
						triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "hospitalpa", "Miembro del personal de recepción por favor para ayudar a un visitante a la sala de emergencias o servicios ambulatorios.")
					end, 5000, 1)
			end
		end, false)

	b6 = guiCreateButton(10, 255, width-20, 40, "Sólo necesito hablar con un miembro del personal.", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b6,
		function()
			endDialog()
			if thePed then
				triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Está bien, enviaré uno.")
				setTimer(function()
						triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "hospitalpa", "Miembro del personal de la recepción por favor para ayudar a un visitante que solicite un miembro del personal.")
					end, 5000, 1)
			end
		end, false)

	b7 = guiCreateButton(10, 300, width-20, 40, "Mmm. No importa.", false, pedDialogWindow)
	addEventHandler("onClientGUIClick", b7, pedDialog_hospital_noHelp, false)

	--showCursor(true)

	triggerServerEvent("airport:ped:outputchat", getResourceRootElement(), thePed, "local", "Bienvenidos a la recepción de LSIA. ¿Puedo ayudarle?")
end
addEvent("lses:ped:hospitalfrontdesk", true)
addEventHandler("lses:ped:hospitalfrontdesk", getRootElement(), pedDialog_hospital)

function endDialog()
	if pedDialogWindow and isElement(pedDialogWindow) then
		destroyElement(pedDialogWindow)
		pedDialogWindow = nil
	end
end

function pedDialog_hospital_noHelp()
	endDialog()
	if thePed then
		triggerServerEvent("lses:ped:outputchat", getResourceRootElement(), thePed, "local", "Okey.")
	end
end