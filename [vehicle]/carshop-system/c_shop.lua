localPlayer = getLocalPlayer()
function carshop_showInfo(carPrice, taxPrice)
	local isOverlayDisabled = getElementData(localPlayer, "hud:isOverlayDisabled")
	if isOverlayDisabled then
		outputChatBox("")
		outputChatBox("Car Dealership")
		outputChatBox("   - Marca: "..(getElementData(source, "brand") or getVehicleNameFromModel( getElementModel( source ) )) )
		outputChatBox("   - Modelo: "..(getElementData(source, "maximemodel") or getVehicleNameFromModel( getElementModel( source ) )) )
		outputChatBox("   - Año: "..(getElementData(source, "year") or "2015") )

		if getVehicleType(source) ~= 'BMX' then
			outputChatBox("   - Kilometraje: "..exports.global:formatMoney(getElementData(source, 'odometer') or 0) .. " Kilometros"  )
		end
		outputChatBox("   - Precio: $"..exports.global:formatMoney(carPrice)  )
		outputChatBox("   - Impuestos: $"..exports.global:formatMoney(taxPrice)  )
		outputChatBox("   (( Modelo Base: "..getVehicleNameFromModel( getElementModel( source ) ).."))"  )
		outputChatBox("Pulse F o Intro para comprar este vehículo")
	else
		local content = {}
		table.insert(content, { getCarShopNicename(getElementData(source, "carshop")) , false, false, false, false, false, false, "title"} )
		table.insert(content, {" " } )
		table.insert(content, {"   - Marca: "..(getElementData(source, "brand") or getVehicleNameFromModel( getElementModel( source ) )) } )
		table.insert(content, {"   - Modelo: "..(getElementData(source, "maximemodel") or getVehicleNameFromModel( getElementModel( source ) ))} )
		table.insert(content, {"   - Año: "..(getElementData(source, "year") or "2015")} )
		if getVehicleType(source) ~= 'BMX' then
			table.insert(content, {"   - Kilometraje: "..exports.global:formatMoney(getElementData(source, 'odometer') or 0) .. " Kilometros"})
		end
		table.insert(content, {"   - Precio: $"..exports.global:formatMoney(carPrice)  } )
		table.insert(content, {"   - Impuestos: $"..exports.global:formatMoney(taxPrice) } )
		table.insert(content, {"   (( Modelo Base: "..getVehicleNameFromModel( getElementModel( source ) ).."))" } )
		table.insert(content, {"Pulse F o Intro para comprar este vehículo" } )
		exports.hud:sendTopRightNotification( content, localPlayer, 240)
	end
end
addEvent("carshop:showInfo", true)
addEventHandler("carshop:showInfo", getRootElement(), carshop_showInfo)

local gui, theVehicle = {}
function carshop_buyCar(carPrice, cashEnabled, bankEnabled)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return false
	end

	if gui["_root"] then
		return
	end

	setElementData(getLocalPlayer(), "exclusiveGUI", true, false)

	theVehicle = source

	guiSetInputEnabled(true)
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 350, 190
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root"] = guiCreateStaticImage(left, top, windowWidth, windowHeight, ":resources/window_body.png", false)
	--guiWindowSetSizable(gui["_root"], false)

	gui["lblText1"] = guiCreateLabel(20, 25, windowWidth-40, 16, "Estás a punto de comprar el siguiente vehículo:", false, gui["_root"])
	gui["lblVehicleName"] = guiCreateLabel(20, 45+5, windowWidth-40, 13, exports.global:getVehicleName(source) , false, gui["_root"])
	guiSetFont(gui["lblVehicleName"], "default-bold-small")
	gui["lblVehicleCost"] = guiCreateLabel(20, 45+15+5, windowWidth-40, 13, "Precio: $"..exports.global:formatMoney(carPrice), false, gui["_root"])
	guiSetFont(gui["lblVehicleCost"], "default-bold-small")
	gui["lblText2"] = guiCreateLabel(20, 45+15*2, windowWidth-40, 70, "Al hacer clic en un botón de pago, usted acepta que no es posible un reembolso. Gracias por elegirnos.", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["lblText2"], "left", true)
	guiLabelSetVerticalAlign(gui["lblText2"], "center", true)

	gui["btnCash"] = guiCreateButton(10, 140, 105, 41, "Pagar en efectivo", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnCash"], carshop_buyCar_click, false)
	guiSetEnabled(gui["btnCash"], cashEnabled)
	if exports.global:hasItem(localPlayer, 263) and carPrice <= 5000000 then
		guiSetText(gui["btnCash"], "Usar crédito automotriz")
		guiSetEnabled(gui["btnCash"], true)
	end

	gui["btnBank"] = guiCreateButton(120, 140, 105, 41, "Pagar por banco", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnBank"], carshop_buyCar_click, false)
	guiSetEnabled(gui["btnBank"], bankEnabled)

	gui["btnCancel"] = guiCreateButton(232, 140, 105, 41, "Cancelar", false, gui["_root"])
	addEventHandler("onClientGUIClick", gui["btnCancel"], carshop_buyCar_close, false)
end
addEvent("carshop:buyCar", true)
addEventHandler("carshop:buyCar", getRootElement(), carshop_buyCar)

function carshop_buyCar_click()
	if exports.global:hasSpaceForItem(getLocalPlayer(), 3, 1) then
		local sourcestr = "cash"
		if (source == gui["btnBank"]) then
			sourcestr = "bank"
		elseif guiGetText(gui["btnCash"]) == "Usar crédito automotriz" then
			sourcestr = "token"
		end
		triggerServerEvent("carshop:buyCar", theVehicle, sourcestr)
	else
		outputChatBox("No tienes espacio en tu inventario para una llave", 0, 255, 0)
	end
	carshop_buyCar_close()
end


function carshop_buyCar_close()
	if gui["_root"] then
		destroyElement(gui["_root"])
		gui = { }
	end
	guiSetInputEnabled(false)
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end
--PREVENT ABUSER TO CHANGE CHAR
addEventHandler ( "account:changingchar", getRootElement(), carshop_buyCar_close )
addEventHandler("onClientChangeChar", getRootElement(), carshop_buyCar_close)

function cleanUp()
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end
addEventHandler("onClientResourceStart", resourceRoot, cleanUp)
