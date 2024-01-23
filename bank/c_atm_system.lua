local onHandlePINChange_data

function ATMCardInteractions(theATM, item, absX, absY, atmLocationName )
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
		return false
	end
	local rightclick = exports.rightclick

	local row = {}
	local rcMenu = rightclick:create("Una tarjeta de cajero automático está atascada en la ranura.")

	row.use = rightclick:addRow("Usar tarjeta de cajero automático")
	addEventHandler( "onClientGUIClick", row.use, function ()
		closeATMCardInteractions()
		requestATMInterfacePIN(theATM, atmLocationName)
	end, false )

	row.take = rightclick:addRow("Tomar tarjeta de cajero automático")
	addEventHandler( "onClientGUIClick", row.take, function ()
		closeATMCardInteractions()
		triggerServerEvent("bank:takeOutATMCard", localPlayer, theATM, item)
	end, false )

	row.leave = rightclick:addRow("Dejalo")
	addEventHandler( "onClientGUIClick", row.leave, closeATMCardInteractions , false )
end
addEvent("bank:ATMCardInteractions", true)
addEventHandler("bank:ATMCardInteractions", getRootElement(), ATMCardInteractions)

function closeATMCardInteractions()
	exports.rightclick:destroy()
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end
--PREVENT ABUSER TO CHANGE CHAR
addEventHandler ( "account:changingchar", getRootElement(), closeATMCardInteractions )
addEventHandler("onClientChangeChar", getRootElement(), closeATMCardInteractions)

local wPIN, Label_Keypad_Number, Label_Error, bEnter = nil
local enteredCode = "0000"
function requestATMInterfacePIN(theATM, atmLocationName)
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() or isPedDead(localPlayer) then
		return false
	end
	if not (wPIN) then
		setElementData(getLocalPlayer(), "exclusiveGUI", true, false)
		local width, height = 600, 400
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		wPIN = guiCreateWindow(x, y, width, height, "Cajero automático #"..getElementData(theATM, "dbid").." en "..(atmLocationName or "Area Desconocida"), false)
			guiWindowSetSizable(wPIN, false)

		local tabPanel = guiCreateTabPanel(0.05, 0.05, 0.9, 0.85, true, wPIN)
		local tabPersonal = guiCreateTab("Please Enter PIN code", tabPanel)

		local posXOffset = 265
		local posYOffset = -105
		local soundID = 33
		enteredCode = "0000"

        Label_Keypad_Number = guiCreateLabel(20,30,220,80,enteredCode,false,tabPersonal)
            guiSetFont(Label_Keypad_Number,"sa-gothic")
            guiLabelSetVerticalAlign(Label_Keypad_Number,"center")
            guiLabelSetHorizontalAlign(Label_Keypad_Number,"center",false)
		Label_Error = guiCreateLabel(20,90,220,30,"Por favor ingrese 4 dígitos del código PIN",false,tabPersonal)
			guiLabelSetVerticalAlign(Label_Error,"center")
            guiLabelSetHorizontalAlign(Label_Error,"center",false)
        local Button_1 = guiCreateButton(0+posXOffset,116+posYOffset,78,66,"1",false,tabPersonal)
            guiSetFont(Button_1,"sa-header")
		addEventHandler( "onClientGUIClick", Button_1, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_1))
		end, false )

        local Button_2 = guiCreateButton(88+posXOffset,116+posYOffset,78,66,"2",false,tabPersonal)
            guiSetFont(Button_2,"sa-header")
		addEventHandler( "onClientGUIClick", Button_2, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_2))
		end, false )

        local Button_3 = guiCreateButton(176+posXOffset,116+posYOffset,78,66,"3",false,tabPersonal)
            guiSetFont(Button_3,"sa-header")
		addEventHandler( "onClientGUIClick", Button_3, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_3))
		end, false )

        local Button_4 = guiCreateButton(0+posXOffset,192+posYOffset,78,66,"4",false,tabPersonal)
            guiSetFont(Button_4,"sa-header")
		addEventHandler( "onClientGUIClick", Button_4, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_4))
		end, false )

        local Button_5 = guiCreateButton(88+posXOffset,192+posYOffset,78,66,"5",false,tabPersonal)
            guiSetFont(Button_5,"sa-header")
		addEventHandler( "onClientGUIClick", Button_5, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_5))
		end, false )

        local Button_6 = guiCreateButton(176+posXOffset,192+posYOffset,78,66,"6",false,tabPersonal)
            guiSetFont(Button_6,"sa-header")
		addEventHandler( "onClientGUIClick", Button_6, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_6))
		end, false )

        local Button_7 = guiCreateButton(0+posXOffset,268+posYOffset,78,66,"7",false,tabPersonal)
            guiSetFont(Button_7,"sa-header")
		addEventHandler( "onClientGUIClick", Button_7, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_7))
		end, false )

        local Button_8 = guiCreateButton(88+posXOffset,268+posYOffset,78,66,"8",false,tabPersonal)
            guiSetFont(Button_8,"sa-header")
		addEventHandler( "onClientGUIClick", Button_8, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_8))
		end, false )

        local Button_9 = guiCreateButton(176+posXOffset,268+posYOffset,78,66,"9",false,tabPersonal)
            guiSetFont(Button_9,"sa-header")
		addEventHandler( "onClientGUIClick", Button_9, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_9))
		end, false )

		local Button_0 = guiCreateButton(88+posXOffset,344+posYOffset,78,66,"0",false,tabPersonal)
            guiSetFont(Button_0,"sa-header")
		addEventHandler( "onClientGUIClick", Button_0, function ()
			playSoundFrontEnd ( soundID )
			updateCode(guiGetText(Button_0))
		end, false )

        local Button_star = guiCreateButton(0+posXOffset,344+posYOffset,78,66,"*",false,tabPersonal)
            guiSetFont(Button_star,"sa-header")
		addEventHandler( "onClientGUIClick", Button_star, function ()
			playSoundFrontEnd ( soundID )
		end, false )

        local Button_sharp = guiCreateButton(176+posXOffset,344+posYOffset,78,66,"#",false,tabPersonal)
            guiSetFont(Button_sharp,"sa-header")
		addEventHandler( "onClientGUIClick", Button_sharp, function ()
			playSoundFrontEnd ( soundID )
		end, false )

		bEnter = guiCreateButton(20,268+posYOffset,225,66,"Entrar",false,tabPersonal)
		addEventHandler( "onClientGUIClick", bEnter, function ()
			guiSetEnabled(bEnter, false)
			triggerServerEvent("bank:checkPINCode", localPlayer, theATM, enteredCode)
		end, false )

        local bClose = guiCreateButton(20,344+posYOffset,225,66,"Salir",false,tabPersonal)
		addEventHandler( "onClientGUIClick", bClose, function ()
			closeATMInterfacePIN()
			triggerServerEvent("bank:ejectATMCard", localPlayer, theATM)
		end, false )

		function updateCode(digital)
			enteredCode = enteredCode..digital
			local len = string.len(enteredCode)
			enteredCode = string.sub(enteredCode, len-3, len)
			guiSetText(Label_Keypad_Number, enteredCode)
		end
		
		triggerEvent("hud:convertUI", localPlayer, wPIN)
		addEventHandler("onClientKey", root, onHandlePINChange)
		onHandlePINChange_data = { buttons = { Button_1, Button_2, Button_3, Button_4, Button_5, Button_6, Button_7, Button_8, Button_9, [0] = Button_0, enter = bEnter}, tab = nil }
	end
end
addEvent("bank:requestATMInterfacePIN", true)
addEventHandler("bank:requestATMInterfacePIN", getRootElement(), requestATMInterfacePIN)

function respondToATMInterfacePIN(Label_Error_Msg, r,g,b, action, otherInfo)
	enteredCode = "0000"
	if Label_Keypad_Number and Label_Error then
		guiSetText(Label_Keypad_Number, enteredCode)
		guiSetText(Label_Error, Label_Error_Msg)
		guiLabelSetColor(Label_Error, r,g,b)
	end

	if action == "cardRemoved" then
		exports.hud:sendBottomNotification(localPlayer, "ATM Maquina", "El cajero automático no funciona correctamente debido a que se extrajo la tarjeta del cajero automático.")
		setTimer(closeATMInterfacePIN, 2000, 1)
	elseif action == "failedLessThan3" then
		exports.hud:sendBottomNotification(localPlayer, "ATM Maquina", "Acceso denegado. Al ingresar el PIN incorrecto más de 3 veces, el cajero automático se tragará la tarjeta. ("..otherInfo.."/3)")
		guiSetEnabled(bEnter, true)
	elseif action == "failedMoreThan3" then
		exports.hud:sendBottomNotification(source, "ATM Maquina", "Access Denied ("..otherInfo.."/3). El cajero automático se ha tragado su tarjeta de cajero automático. Por favor contacta al banco.")
		setTimer(closeATMInterfacePIN, 2000, 1)
	elseif action == "locked" then
		exports.hud:sendBottomNotification(source, "ATM Maquina", "ATM Numero Tarjeta '"..otherInfo.."' está bloqueado y no se puede utilizar, comuníquese con el banco.")
		guiSetEnabled(bEnter, true)
	elseif action == "success" then
		exports.hud:sendBottomNotification(source, "ATM Maquina", "Acceso permitido!")
	elseif action == "changedPIN"  then
		guiSetEnabled(bEnter, true)
		if otherInfo == "ok" then
			guiSetEnabled(tabPersonal, true)
		end
	end
end
addEvent("bank:respondToATMInterfacePIN", true)
addEventHandler("bank:respondToATMInterfacePIN", getRootElement(), respondToATMInterfacePIN)

function closeATMInterfacePIN()
	setElementData(getLocalPlayer(), "exclusiveGUI", false, true)
	showCursor(false)
	--playSoundFrontEnd ( 32 )
	if wPIN then
		destroyElement(wPIN)
		wPIN = nil
	end

	if onHandlePINChange_data then
		removeEventHandler("onClientKey", root, onHandlePINChange)
		onHandlePINChange_data = nil
	end
end
--PREVENT ABUSER TO CHANGE CHAR
addEventHandler ( "account:changingchar", getRootElement(), closeATMInterfacePIN )
addEventHandler("onClientChangeChar", getRootElement(), closeATMInterfacePIN)

local guiATMGranted, tabChangePin = nil
cardInfoSaved = nil -- {cardOwner, cardNumber, balance, cardOwnerCharID, amountLimit}
function openATMGrantedGUI(cardInfo, depositable, limit, withdrawable, theATM, atmLocationName, isPinCodeDefault)
	if not (guiATMGranted) then
		closeATMInterfacePIN()
		_depositable = depositable
		_withdrawable = withdrawable
		lastUsedATM = source
		limitedwithdraw = limit
		cardInfoSaved = cardInfo
		setElementData(getLocalPlayer(), "exclusiveGUI", true, false)

		local width, height = 600, 400
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		guiATMGranted = guiCreateWindow(x, y, width, height, "ATM Maquina #"..getElementData(theATM, "dbid").." en "..(atmLocationName or "Area Desconocida"), false)
		guiWindowSetSizable(guiATMGranted, false)

		tabPanel = guiCreateTabPanel(0.05, 0.05, 0.9, 0.85, true, guiATMGranted)

		tabPersonal = guiCreateTab("Banca personal", tabPanel)
		tabPersonalTransactions = guiCreateTab("Historial de transacciones", tabPanel)
		tabChangePin = guiCreateTab("Cambiar PIN", tabPanel)
		setElementData(tabChangePin,"theATM", theATM)
		createTheRestOf(tabChangePin, isPinCodeDefault)

		local hoursplayed = getElementData(localPlayer, "hoursplayed")

		local lBankName = guiCreateLabel(0.1, 0.05, 0.9, 0.05, "Dueño Tarjeta:                           "..(cardInfo[1] or "Desconocido"):gsub("_", " "), true, tabPersonal)
		guiSetFont(lBankName, "default-bold-small")

		local lBankNumber = guiCreateLabel(0.1, 0.1, 0.9, 0.05, "Número de cuenta bancaria:       "..(cardInfo[2] or "Desconocido"), true, tabPersonal)
		guiSetFont(lBankNumber, "default-bold-small")

		local posYOffset = 0.2
		bClose = guiCreateButton(0.75, 0.91, 0.2, 0.1, "Cerrar", true, guiATMGranted)
		addEventHandler("onClientGUIClick", bClose, function()
			hideATMGrantedGUI()
			triggerServerEvent("bank:ejectATMCard", localPlayer, theATM)
		end, false)

		local balance = cardInfo[3] or 0

		lBalance = guiCreateLabel(0.1, 0.05+posYOffset, 0.9, 0.05, "Balance: $" .. exports.global:formatMoney(balance), true, tabPersonal)
		guiSetFont(lBalance, "default-bold-small")

		if withdrawable then
			-- WITHDRAWAL PERSONAL
			lWithdrawP = guiCreateLabel(0.1, 0.15+posYOffset, 0.2, 0.05, "Retirar:", true, tabPersonal)
			guiSetFont(lWithdrawP, "default-bold-small")

			tWithdrawP = guiCreateEdit(0.22, 0.13+posYOffset, 0.2, 0.075, "0", true, tabPersonal)
			guiSetFont(tWithdrawP, "default-bold-small")
			addEventHandler("onClientGUIClick", tWithdrawP, function()
				if guiGetText(tWithdrawP) == "0" then
					guiSetText(tWithdrawP, "")
				end
			end, false)

			bWithdrawP = guiCreateButton(0.44, 0.13+posYOffset, 0.2, 0.075, "Retirar", true, tabPersonal)
			addEventHandler("onClientGUIClick", bWithdrawP, function()
				local amount = tonumber2(guiGetText(tWithdrawP))
				local money = balance

				local oldamount = getElementData( lastUsedATM, "withdrawn" ) or 0
				if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "Por favor ingrese una cantidad positiva!")
				elseif (amount>money) then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "No tienes suficientes fondos.")
				elseif not _depositable and limitedwithdraw ~= 0 and oldamount + amount > limitedwithdraw then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "Este cajero automático sólo te permite retirar $" .. exports.global:formatMoney( limitedwithdraw - oldamount ) .. ".")
				else
					setElementData( lastUsedATM, "withdrawn", oldamount + amount, false )
					setTimer(
						function( theATM, amount )
							setElementData( theATM, "withdrawn", getElementData( theATM, "withdrawn" ) - amount )
						end,
						120000, 1, lastUsedATM, amount
					)
					hideATMGrantedGUI()
					triggerServerEvent("bank:withdrawATMMoneyPersonal", localPlayer, amount, theATM)
				end
			end, false)
		else
			lWithdrawP = guiCreateLabel(0.1, 0.15+posYOffset, 0.5, 0.05, "Este cajero automático no admite la función de retiro.", true, tabPersonal)
			guiSetFont(lWithdrawP, "default-bold-small")
		end

		if (depositable) then
			-- DEPOSIT PERSONAL
			lDepositP = guiCreateLabel(0.1, 0.25+posYOffset, 0.2, 0.05, "Depósito:", true, tabPersonal)
			guiSetFont(lDepositP, "default-bold-small")

			tDepositP = guiCreateEdit(0.22, 0.23+posYOffset, 0.2, 0.075, "0", true, tabPersonal)
			guiSetFont(tDepositP, "default-bold-small")
			addEventHandler("onClientGUIClick", tDepositP, function()
				if guiGetText(tDepositP) == "0" then
					guiSetText(tDepositP, "")
				end
			end, false)

			bDepositP = guiCreateButton(0.44, 0.23+posYOffset, 0.2, 0.075, "Depósito", true, tabPersonal)
			addEventHandler("onClientGUIClick", bDepositP, function()
				local amount = tonumber2(guiGetText(tDepositP))
				if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "Por favor ingrese una cantidad positiva!")
				elseif not exports.global:hasMoney(localPlayer, amount) then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "No tienes suficientes fondos.")
				else
					hideATMGrantedGUI()
					--outputDebugString("asd")
					triggerServerEvent("bank:depositATMMoneyPersonal", localPlayer, amount, theATM)
				end
			end, false)
		else
			lDepositP = guiCreateLabel(0.1, 0.25+posYOffset, 0.5, 0.05, "Este cajero automático no admite la función de depósito.", true, tabPersonal)
			lCharge = guiCreateLabel(0.1, 0.29+posYOffset, 0.5, 0.05, "Este cajero automático tiene una tarifa de $2 por su uso..", true, tabPersonal)
			guiSetFont(lDepositP, "default-bold-small")
			guiSetFont(lCharge, "default-bold-small")

			if limitedwithdraw > 0 and withdrawable then
				tDepositP = guiCreateLabel(0.67, 0.15+posYOffset, 0.2, 0.05, "Max: $" .. ( limitedwithdraw - ( getElementData( source, "withdrawn" ) or 0 ) ) .. ".", true, tabPersonal)
				guiSetFont(tDepositP, "default-bold-small")
			end
		end

		if hoursplayed >= 12 then
			-- TRANSFER PERSONAL
			lTransferP = guiCreateLabel(0.1, 0.45+posYOffset, 0.2, 0.05, "Transferir:", true, tabPersonal)
			guiSetFont(lTransferP, "default-bold-small")

			tTransferP = guiCreateEdit(0.22, 0.43+posYOffset, 0.2, 0.075, "0", true, tabPersonal)
			guiSetFont(tTransferP, "default-bold-small")
			addEventHandler("onClientGUIClick", tTransferP, function()
				if guiGetText(tTransferP) == "0" then
					guiSetText(tTransferP, "")
				end
			end, false)

			bTransferP = guiCreateButton(0.44, 0.43+posYOffset, 0.2, 0.075, "Transferir a", true, tabPersonal)
			addEventHandler("onClientGUIClick", bTransferP, function()
				local amount = tonumber2(guiGetText(tTransferP))
				local money = balance
				local reason = guiGetText(tTransferPReason)
				local bankAccNo = guiGetText(eTransferP)

				if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "Por favor ingrese una cantidad positiva!")
				elseif (amount>money) then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "No tienes suficientes fondos.")
				elseif reason == "" then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "Por favor ingresa un motivo para la transferencia!")
				elseif bankAccNo == "" then
					exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", "¡Ingrese el número de cuenta bancaria objetivo para la transferencia!")
				else
					triggerServerEvent("bank:transferATMMoneyToPersonal", localPlayer, theATM, amount, bankAccNo, reason)
					guiSetEnabled(guiATMGranted,false)
				end
			end, false)

			eTransferP = guiCreateEdit(0.66, 0.43+posYOffset, 0.3, 0.075, "<Acc No./Faction Name>", true, tabPersonal)
			addEventHandler("onClientGUIClick", eTransferP, function()
				if guiGetText(eTransferP) == "<Acc No./Faction Name>" then
					guiSetText(eTransferP, "")
				end
			end, false)


			lTransferPReason = guiCreateLabel(0.1, 0.55+posYOffset, 0.2, 0.05, "Razón:", true, tabPersonal)
			guiSetFont(lTransferPReason, "default-bold-small")

			tTransferPReason = guiCreateEdit(0.22, 0.54+posYOffset, 0.74, 0.075, "<¿Para qué es esta transacción?>", true, tabPersonal)
			addEventHandler("onClientGUIClick", tTransferPReason, function()
				if guiGetText(tTransferPReason) == "<¿Para qué es esta transacción?>" then
					guiSetText(tTransferPReason, "")
				end
			end, false)
		end

		-- TRANSACTION HISTORY
		createTransactionHistoryTab(tabPersonalTransactions)
		triggerEvent("hud:convertUI", localPlayer, guiATMGranted)
		addEventHandler( "onClientGUITabSwitched", tabPanel, updateTabStuff )
		guiSetInputEnabled(true)
	end
end
addEvent("bank:openATMGrantedGUI", true)
addEventHandler("bank:openATMGrantedGUI", getRootElement(), openATMGrantedGUI)

function createTransactionHistoryTab(parentElement)
	gPersonalTransactions = guiCreateGridList(0.02, 0.02, 0.96, 0.96, true, parentElement)
	local transactionColumns = {
			{ "ID", 0.09 },
			{ "From", 0.2 },
			{ "To", 0.2 },
			{ "Amount", 0.1 },
			{ "Date", 0.2 },
			{ "Reason", 0.3 },
			{ "Details", 0.5 }
		}
	for key, value in ipairs( transactionColumns ) do
		guiGridListAddColumn( gPersonalTransactions, value[1], value[2] or 0.1 )
	end
end

function respondToPendingTransfer(msg, closeATMGUI)
	if closeATMGUI then
		hideATMGrantedGUI()
	else
		if isElement(guiATMGranted) then
			guiSetEnabled(guiATMGranted,true)
		end
	end
	exports.hud:sendBottomNotification(localPlayer, "ATM Cajero", msg)
end
addEvent("bank:respondToPendingTransfer", true)
addEventHandler("bank:respondToPendingTransfer", getRootElement(), respondToPendingTransfer)

function createTheRestOf(parent, isPinCodeDefault)
	local theATM = getElementData(parent,"theATM")
	local posXOffset = 265
	local posYOffset = -105
	local soundID = 33
	enteredCode = "0000"

	setElementData(getLocalPlayer(), "exclusiveGUI", true, false)

	Label_Keypad_Number = guiCreateLabel(20,30,220,80,enteredCode,false,parent)
		guiSetFont(Label_Keypad_Number,"sa-gothic")
		guiLabelSetVerticalAlign(Label_Keypad_Number,"center")
		guiLabelSetHorizontalAlign(Label_Keypad_Number,"center",false)
	Label_Error = guiCreateLabel(20,100,220,115,"Ingrese 4 dígitos del nuevo código PIN",false,parent)
		guiLabelSetVerticalAlign(Label_Error,"top", true)
		guiLabelSetHorizontalAlign(Label_Error,"center",true)
	local Button_1 = guiCreateButton(0+posXOffset,116+posYOffset,78,66,"1",false,parent)
		guiSetFont(Button_1,"sa-header")
	addEventHandler( "onClientGUIClick", Button_1, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_1))
	end, false )

	local Button_2 = guiCreateButton(88+posXOffset,116+posYOffset,78,66,"2",false,parent)
		guiSetFont(Button_2,"sa-header")
	addEventHandler( "onClientGUIClick", Button_2, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_2))
	end, false )

	local Button_3 = guiCreateButton(176+posXOffset,116+posYOffset,78,66,"3",false,parent)
		guiSetFont(Button_3,"sa-header")
	addEventHandler( "onClientGUIClick", Button_3, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_3))
	end, false )

	local Button_4 = guiCreateButton(0+posXOffset,192+posYOffset,78,66,"4",false,parent)
		guiSetFont(Button_4,"sa-header")
	addEventHandler( "onClientGUIClick", Button_4, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_4))
	end, false )

	local Button_5 = guiCreateButton(88+posXOffset,192+posYOffset,78,66,"5",false,parent)
		guiSetFont(Button_5,"sa-header")
	addEventHandler( "onClientGUIClick", Button_5, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_5))
	end, false )

	local Button_6 = guiCreateButton(176+posXOffset,192+posYOffset,78,66,"6",false,parent)
		guiSetFont(Button_6,"sa-header")
	addEventHandler( "onClientGUIClick", Button_6, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_6))
	end, false )

	local Button_7 = guiCreateButton(0+posXOffset,268+posYOffset,78,66,"7",false,parent)
		guiSetFont(Button_7,"sa-header")
	addEventHandler( "onClientGUIClick", Button_7, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_7))
	end, false )

	local Button_8 = guiCreateButton(88+posXOffset,268+posYOffset,78,66,"8",false,parent)
		guiSetFont(Button_8,"sa-header")
	addEventHandler( "onClientGUIClick", Button_8, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_8))
	end, false )

	local Button_9 = guiCreateButton(176+posXOffset,268+posYOffset,78,66,"9",false,parent)
		guiSetFont(Button_9,"sa-header")
	addEventHandler( "onClientGUIClick", Button_9, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_9))
	end, false )

	local Button_0 = guiCreateButton(88+posXOffset,344+posYOffset,78,66,"0",false,parent)
		guiSetFont(Button_0,"sa-header")
	addEventHandler( "onClientGUIClick", Button_0, function ()
		playSoundFrontEnd ( soundID )
		updateCode(guiGetText(Button_0))
	end, false )

	local Button_star = guiCreateButton(0+posXOffset,344+posYOffset,78,66,"*",false,parent)
		guiSetFont(Button_star,"sa-header")
	addEventHandler( "onClientGUIClick", Button_star, function ()
		playSoundFrontEnd ( soundID )
	end, false )

	local Button_sharp = guiCreateButton(176+posXOffset,344+posYOffset,78,66,"#",false,parent)
		guiSetFont(Button_sharp,"sa-header")
	addEventHandler( "onClientGUIClick", Button_sharp, function ()
		playSoundFrontEnd ( soundID )
	end, false )

	bEnter = guiCreateButton(20,344+posYOffset,225,66,"Entrar",false,parent)
	addEventHandler( "onClientGUIClick", bEnter, function ()
		guiSetEnabled(bEnter, false)
		triggerServerEvent("bank:changePIN", localPlayer, theATM, enteredCode)
	end, false )

	-- local bClose = guiCreateButton(20,344+posYOffset,225,66,"Exit",false,parent)
	-- addEventHandler( "onClientGUIClick", bClose, function ()
		-- closeATMInterfacePIN()
		-- triggerServerEvent("bank:ejectATMCard", localPlayer, theATM)
	-- end, false )

	function updateCode(digital)
		enteredCode = enteredCode..digital
		local len = string.len(enteredCode)
		enteredCode = string.sub(enteredCode, len-3, len)
		guiSetText(Label_Keypad_Number, enteredCode)
	end

	if isPinCodeDefault then
		guiSetEnabled(tabPersonal, false)
		guiSetSelectedTab(tabPanel, tabChangePin)
	else
		guiSetEnabled(tabPersonal, true)
		--guiSetSelectedTab(tabPanel, tabChangePin)
	end

	addEventHandler("onClientKey", root, onHandlePINChange)
	onHandlePINChange_data = { buttons = { Button_1, Button_2, Button_3, Button_4, Button_5, Button_6, Button_7, Button_8, Button_9, [0] = Button_0, enter = bEnter}, tab = { parent, tabPanel } }
end

function hideATMGrantedGUI()
	if isElement(guiATMGranted) then
		destroyElement(guiATMGranted)
		guiATMGranted = nil

		guiSetInputEnabled(false)

		cooldown = setTimer(function() cooldown = nil end, 1000, 1)
		setElementData(getLocalPlayer(), "exclusiveGUI", false, false)

		if onHandlePINChange_data then
			removeEventHandler("onClientKey", root, onHandlePINChange)
			onHandlePINChange_data = nil
		end
	end
end
addEvent("hideATMGrantedGUI", true)
addEventHandler("hideATMGrantedGUI", getRootElement(), hideATMGrantedGUI)
--PREVENT ABUSER TO CHANGE CHAR
addEventHandler ( "account:changingchar", getRootElement(), hideATMGrantedGUI )
addEventHandler("onClientChangeChar", getRootElement(), hideATMGrantedGUI)

function clickATM(button, state, absX, absY, wx, wy, wz, element)

	if button == "right" then
		if not cooldown and element and getElementType(element) =="object" and state=="up" and getElementParent(getElementParent(element)) == getResourceRootElement() then
			local px, py, pz = getElementPosition( localPlayer )
			local ax, ay, az = getElementPosition( element )
			if getDistanceBetweenPoints3D( px, py, pz, ax, ay, az ) < 1.3 then
				if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
					return false
				end
				if isAnyOneElseAround(element) then
					exports.hud:sendBottomNotification(localPlayer,"El cajero automático ya está en uso", "Por favor haga fila, un cajero automático solo puede atender a una persona a la vez.")
				else
					triggerServerEvent( "bank:checkInsideATMMachine", localPlayer, element, absX, absY )
				end
			end
		end
	end
end
addEventHandler( "onClientClick", getRootElement(), clickATM )

local wGui = nil
function atmCardExisted()
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
		return false
	end


	setElementData(getLocalPlayer(), "exclusiveGUI", true, false)

	local verticalPos = 0.1
	local numberOfButtons = 2*1.1
	local Width = 350
	local Height = 185
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	local option = {}
	if not (wGui) then
		showCursor(true)
		--NEW CARD
		wGui = guiCreateWindow(X, Y, Width, Height, "'Ya tienes uno en nuestro sistema. ¿Qué tengo que hacer?'", false )
		option[1] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Cancelar mi tarjeta anterior, crear una nueva por favor.", true, wGui )
		addEventHandler( "onClientGUIClick", option[1], function()
			closeAtmCardExisted()
			chooseAtm()
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
		--CANCEL CARD
		option[6] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Ah, olvidalo.", true, wGui )
		addEventHandler( "onClientGUIClick", option[6], function()
			closeAtmCardExisted()
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
	end
end
addEvent("atm:atmCardExisted", true)
addEventHandler( "atm:atmCardExisted", root, atmCardExisted )

function closeAtmCardExisted()
	if wGui then
		destroyElement(wGui)
		wGui = nil
	end
	showCursor(false)
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end

function chooseAtm()
	if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
		return false
	end

	setElementData(getLocalPlayer(), "exclusiveGUI", true, false)

	local verticalPos = 0.1
	local numberOfButtons = 4*1.1
	local Width = 350
	local Height = 350
	local screenwidth, screenheight = guiGetScreenSize()
	local X = (screenwidth - Width)/2
	local Y = (screenheight - Height)/2
	local option = {}
	if not (wGui) then
		showCursor(true)
		--NEW CARD
		wGui = guiCreateWindow(X, Y, Width, Height, "'¿Qué tipo de tarjeta de cajero automático quieres?'", false )
		option[1] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Tarjeta de cajero automático - Básica ($45.000)\nSe puede utilizar para realizar transacciones con un monto muy limitado por día. ($10,000 por 5 horas))", true, wGui )
		if exports.donators:isVisible() then
			guiSetEnable(option[1], false)
		else
			addEventHandler( "onClientGUIClick", option[1], function()
				closeChooseAtm()
				triggerServerEvent("bank:applyForNewATMCard", localPlayer, true, 1)
			end, false )
		end
		verticalPos = verticalPos + 1/numberOfButtons

		option[2] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Tarjeta de cajero automático - Premium ($140.000)\nSe puede utilizar para realizar transacciones con una cantidad justa por día. ($50,000 por 5 horas))", true, wGui )
		addEventHandler( "onClientGUIClick", option[2], function()
			closeChooseAtm()
			triggerServerEvent("bank:applyForNewATMCard", localPlayer, true, 2)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons

		option[3] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "ATM Card - Ultimate ($450.000)\nSe puede utilizar para realizar transacciones con monto ilimitado por día..", true, wGui )
		addEventHandler( "onClientGUIClick", option[3], function()
			closeChooseAtm()
			triggerServerEvent("bank:applyForNewATMCard", localPlayer, true, 3)
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons

		--CANCEL CARD
		option[6] = guiCreateButton( 0.05, verticalPos, 0.9, 1/numberOfButtons, "Ah, olvidalo.", true, wGui )
		addEventHandler( "onClientGUIClick", option[6], function()
			closeChooseAtm()
		end, false )
		verticalPos = verticalPos + 1/numberOfButtons
	end
end
addEvent("atm:chooseAtm", true)
addEventHandler( "atm:chooseAtm", root, chooseAtm )

function closeChooseAtm()
	if wGui then
		destroyElement(wGui)
		wGui = nil
	end
	showCursor(false)
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end

local thisResourceElement = getResourceRootElement(getThisResource())
function cleanUp()
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
	setTimer(hardenATM, 5000, 1)
end
addEventHandler("onClientResourceStart", thisResourceElement, cleanUp)

function hardenATM()
	local count = 0
	for k, theObject in ipairs(getElementsByType("object", getResourceRootElement())) do
		if setObjectBreakable(theObject, false) then
			count = count + 1
		end
	end
	outputDebugString(count.." ATM(s) Han sido endurecidos.")
end

function onHandlePINChange(button, pressOrRelease)
	-- we're pressing the button
	if onHandlePINChange_data and pressOrRelease == true then
		-- do we have an active tab panel?
		if onHandlePINChange_data.tab and (not isElement(onHandlePINChange_data.tab[1]) or guiGetSelectedTab(onHandlePINChange_data.tab[2]) ~= onHandlePINChange_data.tab[1]) then
			return
		end

		for name, guiElement in pairs(onHandlePINChange_data.buttons) do
			name = tostring(name)
			if isElement(guiElement) then
				if button == name or button == ("num_" .. name) then
					triggerEvent("onClientGUIClick", guiElement, "left", "down")
					cancelEvent() -- prevent default keybinds from triggering
				end
			else
				outputDebugString("ATM: boton para " .. tostring(name) .. " irte")
			end
		end
	end
end