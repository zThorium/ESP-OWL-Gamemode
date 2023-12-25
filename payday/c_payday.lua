function cPayDay(faction, pay, profit, interest, donatormoney, tax, incomeTax, vtax, ptax, rent, totalInsFee, grossincome, Perc)
	local cPayDaySound = playSound("mission_accomplished.mp3")
	local bankmoney = getElementData(getLocalPlayer(), "bankmoney")
	local moneyonhand = getElementData(getLocalPlayer(), "money")
	local wealthCheck = moneyonhand + bankmoney
	setSoundVolume(cPayDaySound, 0.7)
	local info = {}
	-- output payslip
	--outputChatBox("-------------------------- PAY SLIP --------------------------", 255, 194, 14)
	table.insert(info, {"Dia de Paga"})	
	table.insert(info, {""})
	--table.insert(info, {""})
	-- state earnings/money from faction
	if not faction then
		if (pay + tax > 0) then
			--outputChatBox(, 255, 194, 14, true)
			table.insert(info, {"  Beneficios de estado: $" .. exports.global:formatMoney(pay+tax)})	
		end
	else
		if (pay + tax > 0) then
			--outputChatBox(, 255, 194, 14, true)
			table.insert(info, {"  Salario pagado: $" .. exports.global:formatMoney(pay+tax)})
		end
	end
	
	-- business profit
	if (profit > 0) then
		--outputChatBox(, 255, 194, 14, true)
		table.insert(info, {"  Beneficio empresarial: $" .. exports.global:formatMoney(profit)})
	end
	
	-- bank interest
	if (interest > 0) then
		--outputChatBox(,255, 194, 14, true)
		table.insert(info, {"  Interés bancario: $" .. exports.global:formatMoney(interest) .. " (≈" ..("%.2f"):format(Perc) .. "%)"})
	end
	
	-- donator money (nonRP)
	if (donatormoney > 0) then
		--outputChatBox(, 255, 194, 14, true)
		table.insert(info, {"  Dinero del donante: $" .. exports.global:formatMoney(donatormoney)})
	end
	
	-- Above all the + stuff
	-- Now the - stuff below
	
	-- income tax
	if (tax > 0) then
		--outputChatBox(, 255, 194, 14, true)
		table.insert(info, {"  Impuesto sobre la Renta de " .. (math.ceil(incomeTax*100)) .. "%: $" .. exports.global:formatMoney(tax)})
	end
	
	if (vtax > 0) then
		--outputChatBox(, 255, 194, 14, true)
		table.insert(info, {"  Impuesto sobre vehículos: $" .. exports.global:formatMoney(vtax)})
	end

	if (totalInsFee > 0) then
		table.insert(info, {"  Seguro de vehículo: $" .. exports.global:formatMoney(totalInsFee)})
	end
	
	if (ptax > 0) then
		--outputChatBox(, 255, 194, 14, true )
		table.insert(info, {"  Gastos de propiedad: $" .. exports.global:formatMoney(ptax)})
	end
	
	if (rent > 0) then
		--outputChatBox(, 255, 194, 14, true)
		table.insert(info, {"  Renta del apartamento: $" .. exports.global:formatMoney(rent)})
	end
	
	--outputChatBox("------------------------------------------------------------------", 255, 194, 14)
	
	if grossincome == 0 then
		--outputChatBox(,255, 194, 14, true)
		table.insert(info, {"  Ingresos brutos: $0"})
	elseif (grossincome > 0) then --ACA ENTREA
		--outputChatBox(,255, 194, 14, true)
		--outputChatBox(, 255, 194, 14)
		table.insert(info, {"  Ingresos brutos: $" .. exports.global:formatMoney(grossincome)})
		table.insert(info, {"  Observación(es): Transferido a su cuenta bancaria."})
	else
		--outputChatBox(, 255, 194, 14, true)
		--outputChatBox(, 255, 194, 14)
		table.insert(info, {"  Ingresos brutos: $" .. exports.global:formatMoney(grossincome)})
		table.insert(info, {"  Observación(es): Tomando de su cuenta bancaria."})
	end
	
	
	if (pay + tax == 0) then
		if not (faction) then
			--outputChatBox(, 255, 0, 0)
			table.insert(info, {"  El gobierno no podía permitirse el lujo de pagarle sus beneficios estatales."})
		else
			--outputChatBox(, 255, 0, 0)
			table.insert(info, {"  Su empleador no podía permitirse el lujo de pagar su salario."})
		end
	end
	
	if (rent == -1) then
		--outputChatBox(, 255, 0, 0)
		table.insert(info, {"  Te han desalojado de tu apartamento porque ya no puedes pagar el alquiler.."})
	end

	if (totalInsFee == -1) then
		table.insert(info, {"  Tu seguro ha sido eliminado porque no lo pagaste."})
	end
	
	--outputChatBox("------------------------------------------------------------------", 255, 194, 14)
	-- end of output payslip
	if exports.hud:isActive() then
		triggerEvent("hudOverlay:drawOverlayTopRight", localPlayer, info ) 
	end
	triggerEvent("updateWaves", getLocalPlayer())

	-- trigger one event to run whatever functions anywhere that needs to be executed hourly
	triggerEvent('payday:run', resourceRoot)
end
addEvent("cPayDay", true)
addEventHandler("cPayDay", getRootElement(), cPayDay)

function startResource()
	addEvent('payday:run', true)
end
addEventHandler("onClientResourceStart", getResourceRootElement(), startResource)