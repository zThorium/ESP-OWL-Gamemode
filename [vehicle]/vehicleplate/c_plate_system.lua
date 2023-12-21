--Warning, not sure who originally made this but it's very noobish and messy. If you're about to modify this, better remake a new one :< / maxime
local gabby = createPed(150,  1103.900390625, -768, 976.52996826172)
--setPedRotation(gabby, 270.00) -- Old Rotation
setPedRotation(gabby, 180)
setElementDimension(gabby, 4)
setElementInterior(gabby, 5)
setElementData(gabby, "talk", 1)
setElementData(gabby, "name", "Gabrielle McCoy")
setElementFrozen(gabby, true)
setPedAnimation ( gabby, "FOOD", "FF_Sit_Look", -1, true, false, false )

local plateCheck, newplates, efinalWindow, taxLabel = nil

local tonny = createPed(120, 1111.36328125, -776.4462890625, 976.80633544922)
setPedRotation(tonny, 97.98)
setElementDimension(tonny, 4)
setElementInterior(tonny, 5)
setElementData(tonny, "talk", 1)
setElementData(tonny, "name", "Tony Johnston")
setElementFrozen(tonny, true)
setPedAnimation ( tonny, "FOOD", "FF_Sit_Look", -1, true, false, false )

function getPaperFromTony(button, state, absX, absY, wx, wy, wz, element)
    if (element) and (getElementType(element)=="ped") and (button=="right") and (state=="down") then --if it's a right-click on a object
		local pedName = getElementData(element, "name") or "The Storekeeper"
		pedName = tostring(pedName):gsub("_", " ")

        local rcMenu
        if(pedName == "Tony Johnston") then
            rcMenu = exports.rightclick:create(pedName)
            showCursor(true)
            local row = exports.rightclick:addRow("Comprar papel transferencia de vehiculo - 10000$")
            addEventHandler("onClientGUIClick", row,  function (button, state)
            	if exports.global:hasMoney(localPlayer, 10000) and getElementData(localPlayer, "loggedin") == 1 then
                	triggerServerEvent("givePaperToSellVehicle", getResourceRootElement(), localPlayer)
					showCursor(false)
				else
					outputChatBox("No tienes 10000$.")
					showCursor(false)
                end
            end, false)

            local row2 = exports.rightclick:addRow("Close")
            addEventHandler("onClientGUIClick", row2,  function (button, state)
                exports.rightclick:destroy(rcMenu)
                showCursor(false)
            end, false)
        end
    end
end
addEventHandler("onClientClick", getRootElement(), getPaperFromTony, true)

function cBeginGUI()
	local lplayer = getLocalPlayer()
	triggerServerEvent("platePedTalk", lplayer, 1)

	local width, height = 150, 225 --175
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)

	--greetingWindow = guiCreateWindow(x, y, width, height, "Which are you here for?", false)
	greetingWindow = guiCreateStaticImage(x, y, width, height, ":resources/window_body.png", false)
	local width2, height2 = 10, 10
	local x = scrWidth/2 - (width2/2)
	local y = scrHeight/2 - (height2/2)

	--Buttons
	plates = guiCreateButton(0.1, 0.1, 0.75, 0.15, "Patentes Custom", true, greetingWindow)
	addEventHandler("onClientGUIClick", plates, fetchPlateList)

	register = guiCreateButton(0.1, 0.32, 0.75, 0.15, "Registro", true, greetingWindow)
	addEventHandler("onClientGUIClick", register, fetchRegisterList)

	insurance = guiCreateButton(0.1, 0.53, 0.75, 0.15, "Seguro", true, greetingWindow)
	addEventHandler("onClientGUIClick", insurance, fetchInsuranceList)

	neither = guiCreateButton(0.1, 0.75, 0.75, 0.15, "Nada", true, greetingWindow)
	addEventHandler("onClientGUIClick", neither, closeWindow)

	--Quick Settings
	--guiWindowSetSizable(greetingWindow, false)
	--guiWindowSetMovable(greetingWindow, true)
	guiSetVisible(greetingWindow, true)
	showCursor(true)
end
addEvent("cBeginPlate", true)
addEventHandler("cBeginPlate", getRootElement(), cBeginGUI)

function fetchPlateList()
	if (source==plates) then
		destroyElement(greetingWindow)
		--triggerServerEvent("platePedTalk", getLocalPlayer(), 3)
		triggerServerEvent("vehicle-plate-system:list", getLocalPlayer())
		showCursor(false)
	end
end

function fetchRegisterList()
	if (source==register) then
		destroyElement(greetingWindow)
		--triggerServerEvent("platePedTalk", getLocalPlayer(), 3)
		triggerServerEvent("vehicle-plate-system:registerlist", getLocalPlayer())
		showCursor(false)
	end
end

function fetchInsuranceList()
	if (source==insurance) then
		destroyElement(greetingWindow)
		--triggerServerEvent("platePedTalk", getLocalPlayer(), 3)
		triggerServerEvent("vehicle-plate-system:insurancelist", getLocalPlayer())
		showCursor(false)
	end
end

function PlateWindow(vehicleList)
	local lplayer = getLocalPlayer()

	local width, height = 500, 400
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)

	mainVehWindow = guiCreateWindow(x, y, width, height, "Patentes vehículos: Registro", false)

	guiCreateLabel(0.03, 0.08, 2.0, 0.1, "¿Para qué vehículo desea registrar patentes?", true, mainVehWindow)
	vehlist = guiCreateGridList(0.03, 0.15, 1, 0.73, true, mainVehWindow)

	ovid = guiGridListAddColumn(vehlist, "ID", 0.1)
	ov = guiGridListAddColumn(vehlist, "Vehículos propios", 0.5)
	ovcp = guiGridListAddColumn(vehlist, "Patentes actuales", 0.3)


	for i,r in ipairs(vehicleList) do
		local row = guiGridListAddRow(vehlist)
		local vid = r[1]
		local v = r[2]
		--local vm = getElementModel(v)
		guiGridListSetItemText(vehlist, row, ovid, tostring(vid), false, false)
		guiGridListSetItemText(vehlist, row, ov, exports.global:getVehicleName(v) , false, false) --tostring(getVehicleNameFromModel(vm))
		guiGridListSetItemText(vehlist, row, ovcp, tostring(getVehiclePlateText(v) or ""), false, false)
	end

	--Buttons
	close = guiCreateButton(0.50, 0.90, 0.50, 0.10, "Salir", true, mainVehWindow)
	addEventHandler("onClientGUIClick", close, closeWindow)

	--OnDoubleClick
	addEventHandler("onClientGUIDoubleClick", vehlist, editPlateWindow)

	--Quick Settings
	guiWindowSetSizable(mainVehWindow, false)
	guiWindowSetMovable(mainVehWindow, true)
	guiSetVisible(mainVehWindow, true)

	showCursor(true)
end
addEvent("vehicle-plate-system:clist", true)
addEventHandler("vehicle-plate-system:clist", getRootElement(), PlateWindow)

function registerWindow(vehicleList)
	local lplayer = getLocalPlayer()

	local width, height = 500, 400
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)

	mainVehWindow = guiCreateWindow(x, y, width, height, "Registro de vehiculos", false)

	guiCreateLabel(0.03, 0.08, 2.0, 0.1, "¿Qué vehículo desea dar de alta/baja?", true, mainVehWindow)
	vehlist = guiCreateGridList(0.03, 0.15, 1, 0.73, true, mainVehWindow)

	ovid = guiGridListAddColumn(vehlist, "ID", 0.1)
	ov = guiGridListAddColumn(vehlist, "Vehículos propios", 0.65)
	ovcp = guiGridListAddColumn(vehlist, "Estado de registro", 0.15)


	for i,r in ipairs(vehicleList) do
		local row = guiGridListAddRow(vehlist)
		local vid = r[1]
		local v = r[2]
        local faction = r.faction
		--local vm = getElementModel(v)
		local plateState = getElementData(v, "registered")
		guiGridListSetItemText(vehlist, row, ovid, tostring(vid), false, false)
		guiGridListSetItemText(vehlist, row, ov, (faction and "Fac#"..faction.." - " or "") .. exports.global:getVehicleName(v) , false, false) --tostring(getVehicleNameFromModel(vm))
		if plateState == 0 then
		    guiGridListSetItemText(vehlist, row, ovcp, "No registrado", false, false)
		else
		    guiGridListSetItemText(vehlist, row, ovcp, "Registrado", false, false)
		end
	end

	--Buttons
	close = guiCreateButton(0.50, 0.90, 0.50, 0.10, "Salir", true, mainVehWindow)
	addEventHandler("onClientGUIClick", close, closeWindow)

	--OnDoubleClick
	addEventHandler("onClientGUIDoubleClick", vehlist, updateRegistration)

	--Quick Settings
	guiWindowSetSizable(mainVehWindow, false)
	guiWindowSetMovable(mainVehWindow, true)
	guiSetVisible(mainVehWindow, true)

	showCursor(true)
end
addEvent("vehicle-plate-system:rlist", true)
addEventHandler("vehicle-plate-system:rlist", getRootElement(), registerWindow)

function togMainVehWindow(state)
	if mainVehWindow and isElement(mainVehWindow) then
		guiSetEnabled(mainVehWindow, state)
	end
end

local plateCheck, submitNP = nil
function editPlateWindow()
	local cost = exports.donators:getPerks(23)[2]
	local sr, sc = guiGridListGetSelectedItem(vehlist)
	svnum = guiGridListGetItemText(vehlist, sr, 1)
	if (source == vehlist) and not (svnum == "") then
		togMainVehWindow(false)
		local width, height = 300, 210
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		efinalWindow = guiCreateStaticImage(x, y, width, height, ":resources/window_body.png", false)
		local mainT = guiCreateLabel(0.03, 0.08, 0.96, 0.2, "Cambiando patentes para el vehiculo ID: " .. svnum .. ".\nPor favor ingresa la nueva patente:", true, efinalWindow)
		guiLabelSetHorizontalAlign(mainT, "center", true)

		newplates = guiCreateEdit(0.1, 0.3, 0.8, 0.15, "", true, efinalWindow)
		guiEditSetMaxLength(newplates, 8)

		addEventHandler("onClientGUIChanged", newplates, checkPlateBox)

		plateCheck = guiCreateLabel(0, 0.5, 1, 0.1, "Por favor elige una patente que te guste", true, efinalWindow)
		guiLabelSetHorizontalAlign(plateCheck, "center", true)

		--Buttons

		submitNP = guiCreateButton(0.1, 0.60, 0.8, 0.15, "Comprar (Costo: "..cost.." GCs)", true, efinalWindow)
		addEventHandler("onClientGUIClick", submitNP, function ()
			if source == submitNP then
				local data = guiGetText(newplates)
				local vehid = tonumber(svnum)
				triggerServerEvent("sNewPlates", getLocalPlayer(), data, vehid)
				guiSetInputEnabled(false)
				destroyElement(mainVehWindow)
				destroyElement(efinalWindow)
				showCursor(false)
			end
		end)
		guiSetEnabled(submitNP, false)

		finalx = guiCreateButton(0.1, 0.80, 0.8, 0.15, "Salir", true, efinalWindow)
		addEventHandler("onClientGUIClick", finalx, closeWindow)

		--Quick Settings
		guiSetInputEnabled(true)
		guiSetVisible(efinalWindow, true)
		showCursor(true)

		--Disabled , moving to donor perk
		--guiSetEnabled(submitNP,false)
	end
end

function checkPlateBox()
	local theText = string.upper(guiGetText(source))
		guiSetText(source,theText)
	if checkPlate(theText) then
		guiSetText(plateCheck, "'"..theText.."' es una patente valida!")
		guiLabelSetColor(plateCheck, 0, 255, 0)
		guiSetEnabled(submitNP, true)
	else
		guiSetText(plateCheck, "'"..theText.."' no es valida.")
		guiLabelSetColor(plateCheck, 255, 0, 0)
		guiSetEnabled(submitNP, false)
	end
end

function updateRegistration()
	local sr, sc = guiGridListGetSelectedItem(vehlist)
	svnum = guiGridListGetItemText(vehlist, sr, 1)
	local state = guiGridListGetItemText(vehlist, sr, 3)
	local carname = guiGridListGetItemText(vehlist, sr, 2)
	if (source == vehlist) and not (svnum == "") then
		togMainVehWindow(false)
		local width, height = 300, 210
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		efinalWindow = guiCreateStaticImage(x, y, width, height, ":resources/window_body.png", false)
		local mainT = guiCreateLabel(0.03, 0.08, 0.96, 0.2, (state == "No registrado" and "Registro de" or "Desregistro de")..(" vehiculo ID: " .. svnum .. "."), true, efinalWindow)
		taxLabel = guiCreateLabel(0.03, 0.18, 0.96, 0.2, "Impuesto del vehiculo: cargando...", true, efinalWindow)
		triggerServerEvent("plate:grabTax", resourceRoot, svnum)
		guiLabelSetHorizontalAlign(mainT, "center", true)
		guiLabelSetHorizontalAlign(taxLabel, "center", true)

		local second = guiCreateLabel(0.03, 0.3, 0.96, 0.2, carname, true, efinalWindow)
		guiLabelSetHorizontalAlign(second, "center", true)
		guiSetFont(second, "default-bold-small")
		--Buttons

		local submitNP2 = guiCreateButton(0.1, 0.60, 0.8, 0.15, (state == "No registrado" and "Registrar (Costo: $80000)" or "Desregistrar (Costo: $40000)") , true, efinalWindow)
		addEventHandler("onClientGUIClick", submitNP2, function ()
			if source == submitNP2 then
				triggerServerEvent("sNewReg", getLocalPlayer(),  tonumber(svnum))
				guiSetInputEnabled(false)
				destroyElement(mainVehWindow)
				destroyElement(efinalWindow)
				showCursor(false)
			end
		end)


		if exports.global:hasMoney(localPlayer,  state == "No registrado" and 80000 or 40000 ) then
			guiSetEnabled(submitNP2, true)
		else
			guiSetEnabled(submitNP2, false)
		end

		finalx = guiCreateButton(0.1, 0.80, 0.8, 0.15, "Salir", true, efinalWindow)
		addEventHandler("onClientGUIClick", finalx, closeWindow)

		--Quick Settings
		guiSetInputEnabled(true)
		guiSetVisible(efinalWindow, true)
		showCursor(true)
	end
end

addEvent("plate:updateTaxLabel", true)
addEventHandler("plate:updateTaxLabel", localPlayer, function(tax)
	guiSetText(taxLabel, "Impuesto del vehiculo: $" .. exports.global:formatMoney(tax))
end)

function setRegValue()
	if (source==submitNP) then
		local vehid =


		guiSetInputEnabled(false)
		destroyElement(mainVehWindow)
		destroyElement(efinalWindow)
		showCursor(false)
	end
end

function closeWindow()
	if (source==close) then
		showCursor(false)
		destroyElement(mainVehWindow)
		toggleAllControls(true)
		triggerEvent("onClientPlayerWeaponCheck", localPlayer)
	elseif (source==neither) then
		showCursor(false)
		destroyElement(greetingWindow)
		toggleAllControls(true)
		triggerEvent("onClientPlayerWeaponCheck", localPlayer)
		triggerServerEvent("platePedTalk", getLocalPlayer(), 4)
	elseif (source==finalx) then
		guiSetInputEnabled(false)
		destroyElement(mainVehWindow)
		destroyElement(efinalWindow)
		showCursor(false)
		toggleAllControls(true)
		triggerEvent("onClientPlayerWeaponCheck", localPlayer)
		triggerServerEvent("platePedTalk", getLocalPlayer(), 4)
	end
end

function insuranceWindow(vehicleList)
	local lplayer = getLocalPlayer()

	local width, height = 500, 400
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)

	mainVehWindow = guiCreateWindow(x, y, width, height, "Seguros de vehiculos", false)

	local label = guiCreateLabel(0.03, 0.08, 0.94, 0.2, "Este es un resumen de los seguros actuales de su vehículo. \nPara contratar un seguro, ponte en contacto con una compañía de seguros.", true, mainVehWindow)
	guiLabelSetHorizontalAlign(label, "left", true)

	vehlist = guiCreateGridList(0.03, 0.25, 1, 0.63, true, mainVehWindow)

	ovid = guiGridListAddColumn(vehlist, "ID", 0.1)
	ov = guiGridListAddColumn(vehlist, "Vehiculo", 0.5)
	ovcp = guiGridListAddColumn(vehlist, "Asegurado por", 0.3)

	insuredVehicles = {}

	for i,r in ipairs(vehicleList) do
		local row = guiGridListAddRow(vehlist)
		local vid = r[1]
		local v = r[2]
		local data = r[3]
		--local vm = getElementModel(v)
		--outputDebugString("#data = "..tostring(#data))
		local insuredBy = data.insurancecompanyname or ""
		guiGridListSetItemText(vehlist, row, ovid, tostring(vid), false, false)
		guiGridListSetItemText(vehlist, row, ov, exports.global:getVehicleName(v) , false, false) --tostring(getVehicleNameFromModel(vm))
		guiGridListSetItemText(vehlist, row, ovcp, tostring(insuredBy), false, false)
		--outputDebugString("insuredVehicles["..tostring(vid).."] = {"..tostring(v)..", "..tostring(data).."#"..tostring(#data).."}")
		--outputDebugString("policyid = "..tostring(data.policyid))
		insuredVehicles[tonumber(vid)] = {v, data}
	end

	--Buttons
	close = guiCreateButton(0.50, 0.90, 0.50, 0.10, "Salir", true, mainVehWindow)
	addEventHandler("onClientGUIClick", close, closeWindow)

	--OnDoubleClick
	addEventHandler("onClientGUIDoubleClick", vehlist, insuranceDetails)

	--Quick Settings
	guiWindowSetSizable(mainVehWindow, false)
	guiWindowSetMovable(mainVehWindow, true)
	guiSetVisible(mainVehWindow, true)

	--showCursor(true)
end
addEvent("vehicle-plate-system:ilist", true)
addEventHandler("vehicle-plate-system:ilist", getRootElement(), insuranceWindow)

function closeInsuranceDetails()
	if source == finalx then
		destroyElement(efinalWindow)
		efinalWindow = nil
		--togMainVehWindow(true)
		showCursor(false)
	end
end
function insuranceDetails()
	local sr, sc = guiGridListGetSelectedItem(vehlist)
	svnum = guiGridListGetItemText(vehlist, sr, 1)
	local carname = guiGridListGetItemText(vehlist, sr, 2)
	if (source == vehlist) and not (svnum == "") then
		togMainVehWindow(false)
		local width, height = 300, 210
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		efinalWindow = guiCreateStaticImage(x, y, width, height, ":resources/window_body.png", false)

		mainT = guiCreateLabel(0.03, 0.03, 0.96, 0.57, "", true, efinalWindow)
		guiLabelSetHorizontalAlign(mainT, "left", true)

		local submitNP2 = guiCreateButton(0.1, 0.60, 0.8, 0.15, "Cancelar seguro", true, efinalWindow)
		addEventHandler("onClientGUIClick", submitNP2, function ()
			if source == submitNP2 then
				if(guiGetText(source) == "Yes") then
					triggerServerEvent("insurance:cancel", getLocalPlayer(),  tonumber(svnum))
					guiSetInputEnabled(false)
					destroyElement(mainVehWindow)
					destroyElement(efinalWindow)
					showCursor(false)
				else
					guiSetText(mainT, "¿Está seguro de que desea cancelar esta póliza de seguro? Si lo hace, dejará de tener la protección.")
					guiLabelSetHorizontalAlign(mainT, "center", true)
					guiLabelSetVerticalAlign(mainT, "center")
					guiSetText(submitNP2, "Yes")
					guiSetText(finalx, "No")
				end
			end
		end)

		finalx = guiCreateButton(0.1, 0.80, 0.8, 0.15, "Salir", true, efinalWindow)
		addEventHandler("onClientGUIClick", finalx, closeWindow) --closeInsuranceDetails

		--Quick Settings
		guiSetInputEnabled(true)
		guiSetVisible(efinalWindow, true)
		--showCursor(true)

		--outputDebugString("insuredVehicles = "..tostring(insuredVehicles))
		--outputDebugString("insuredVehicles["..tostring(svnum).."] = "..tostring(insuredVehicles[tonumber(svnum)]))
		--outputDebugString("insuredVehicles["..tostring(svnum).."][2]")
		local data = insuredVehicles[tonumber(svnum)][2]
		--outputDebugString("data = "..tostring(data))
		if not data then data = {} end
		--outputDebugString("#data = "..tostring(#data))
		--[[
		if not data or #data < 1 then
			guiSetInputEnabled(false)
			destroyElement(mainVehWindow)
			destroyElement(efinalWindow)
			showCursor(false)
		end
		--]]

		local string = ""
		string = string.."ID: "..tostring(svnum).."\n"
		string = string.."Vehiculo: "..tostring(carname).."\n"
		local insuranceFactionName = exports.factions:getFactionName(tonumber(data.insurancefaction))
		local insuranceFactionText = ""
		if insuranceFactionName then
			if insuranceFactionName ~= data.insurancecompanyname then
				insuranceFactionText = " ("..tostring(insuranceFactionName)..")"
			end
		end
		string = string.."Asegurado por: "..tostring(data.insurancecompanyname)..insuranceFactionText.."\n"
		string = string.."Cliente: "..tostring(data.customername).."\n"
		string = string.."Asegurado desde: "..tostring(data.date).."\n"
		string = string.."Plan seguro: "..tostring(data.protection).."\n"
		string = string.."Premium: $"..exports.global:formatMoney(tonumber(data.premium)).."\n"

		guiSetText(mainT, tostring(string))
	end
end
