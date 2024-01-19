function showStats(thePlayer, commandName, targetPlayerName)
	if getElementData(thePlayer, "loggedin") ~= 1 then
		outputChatBox("No estas logeado.", thePlayer, 255, 0, 0)
		return
	end

	local showPlayer = thePlayer
	if exports.integration:isPlayerTrialAdmin(thePlayer) and targetPlayerName then
		targetPlayer = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
		if targetPlayer then
			if getElementData(targetPlayer, "loggedin") == 1 then
				thePlayer = targetPlayer
			else
				outputChatBox("Jugador no esta logeado.", showPlayer, 255, 0, 0)
				return
			end
		else
			return
		end
	end
	
	local isOverlayDisabled = getElementData(showPlayer, "hud:isOverlayDisabled")
	--LICNESES
	local carlicense = getElementData(thePlayer, "license.car")
	local bikelicense = getElementData(thePlayer, "license.bike")
	local boatlicense = getElementData(thePlayer, "license.boat")
	--local pilotlicense = getElementData(thePlayer, "license.pilot")
	local fishlicense = getElementData(thePlayer, "license.fish")
	local gunlicense = getElementData(thePlayer, "license.gun")
	local gun2license = getElementData(thePlayer, "license.gun2")
	if (carlicense==1) then
		carlicense = "Si"
	elseif (carlicense==3) then
		carlicense = "Teorico Aprobado"
	else
		carlicense = "No"
	end
	if (bikelicense==1) then
		bikelicense = "Si"
	elseif (bikelicense==3) then
		bikelicense = "Teorico Aprobado"
	else
		bikelicense = "No"
	end
	if (boatlicense==1) then
		boatlicense = "Si"
	else
		boatlicense = "No"
	end
	
	local pilotLicenses = exports.mdc:getPlayerPilotLicenses(thePlayer) or {}
	local pilotlicense = ""
	local maxShow = 5
	local numAdded = 0
	local numOverflow = 0
	local typeratings = 0
	for k,v in ipairs(pilotLicenses) do
		local licenseID = v[1]
		local licenseValue = v[2]
		local licenseName = v[3]
		if licenseID == 7 then --if typerating
			if licenseValue then
				typeratings = typeratings + 1
			end
		else
			if numAdded >= maxShow then
				numOverflow = numOverflow + 1
			else
				if numAdded == 0 then
					pilotlicense = pilotlicense..tostring(licenseName)
				else
					pilotlicense = pilotlicense..", "..tostring(licenseName)
				end
				numAdded = numAdded + 1
			end
		end
	end
	if(numAdded == 0) then
		pilotlicense = "No"
	else
		if numOverflow > 0 then
			pilotlicense = pilotlicense.." (+"..tostring(numOverflow+typeratings)..")"
		else
			if typeratings > 0 then
				pilotlicense = pilotlicense.." (+"..tostring(typeratings)..")"
			else
				pilotlicense = pilotlicense.."."
			end
		end
	end
	
	if (fishlicense==1) then
		fishlicense = "Si"
	else
		fishlicense = "No"
	end
	if (gunlicense==1) then
		gunlicense = "Si"
	else
		gunlicense = "No"
	end
	if (gun2license==1) then
		gun2license = "Si"
	else
		gun2license = "No"
	end
	--VEHICLES
	local dbid = tonumber(getElementData(thePlayer, "dbid"))
	local carids = ""
	local numcars = 0
	local printCar = ""
	for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
		local owner = tonumber(getElementData(value, "owner"))

		if (owner) and (owner==dbid) then
			local id = getElementData(value, "dbid")
			carids = carids .. id .. ", "
			numcars = numcars + 1
			exports.anticheat:changeProtectedElementDataEx(value, "owner_last_login", exports.datetime:now(), true)
		end
	end
	printCar = numcars .. "/" .. getElementData(thePlayer, "maxvehicles")

	-- PROPERTIES
	local properties = ""
	local numproperties = 0
	for key, value in ipairs(getElementsByType("interior")) do
		local stt = getElementData(value, "status")
		if stt.owner and stt.owner == dbid and getElementData(value, "name") then
			local id = getElementData(value, "dbid")
			properties = properties .. id .. ", "
			numproperties = numproperties + 1
			--Update owner last login / MAXIME 2015.01.07
			exports.anticheat:changeProtectedElementDataEx(value, "owner_last_login", exports.datetime:now(), true)
		end
	end

	if (properties=="") then properties = "None.  " end
	if (carids=="") then carids = "None.  " end
	--FETCH ABOVE
	local hoursplayed = getElementData(thePlayer, "hoursplayed")
	local info = {}
	if isOverlayDisabled then
		outputChatBox(getPlayerName(thePlayer):gsub("_", " "), showPlayer , 255, 194, 14)
		outputChatBox(" Licencia de conducir: " .. carlicense, showPlayer)
		outputChatBox(" Licencia de Motocicleta: " .. bikelicense, showPlayer)
		outputChatBox(" Licencia de Bote: " .. boatlicense, showPlayer)
		outputChatBox(" Licencia de Piloto: " .. pilotlicense, showPlayer)
		outputChatBox(" Licencia Nivel 1 Armas: " .. gunlicense , showPlayer)
		outputChatBox(" Licencia Nivel 2 Armas: " .. gun2license , showPlayer)
		outputChatBox(" Permiso de Pesca: " .. fishlicense, showPlayer)
		outputChatBox(" Vehiculos (" .. printCar .. "): " .. string.sub(carids, 1, string.len(carids)-2) , showPlayer)
		outputChatBox(" Propiedades (" .. numproperties .. "/"..(getElementData(thePlayer, "maxinteriors") or 10).."): " .. string.sub(properties, 1, string.len(properties)-2) , showPlayer)
		outputChatBox(" Tiempo Jugado Personaje: " .. hoursplayed .. " horas." , showPlayer)
		outputChatBox(" Lenguajes: " , showPlayer)
	else
		info = {
			{getPlayerName(thePlayer):gsub("_", " ")},
			{""},
			{" Fecha Cumpleaños: "..exports.global:getPlayerDoB(thePlayer)},
			{" Licencia de Conducir: " .. carlicense},
			{" Licencia de Motocicleta: " .. bikelicense},
			{" Licencia de Bote: " .. boatlicense},
			{" Licencia de Piloto: " .. pilotlicense},
			{" Licencia Nivel 1 Armas: " .. gunlicense},
			{" Licencia Nivel 2 Armas: " .. gun2license},
			{" Permiso de Pesca: " .. fishlicense},
			{" Vehiculos (" .. printCar .. "): " .. string.sub(carids, 1, string.len(carids)-2)},
			{" Propiedades (" .. numproperties .. "/"..(getElementData(thePlayer, "maxinteriors") or 10).."): " .. string.sub(properties, 1, string.len(properties)-2)},
			{" Tiempo Jugado Personaje: " .. hoursplayed .. " horas."},
			{" Lenguajes: "},
		}
	end
	--LANGUAGES
	for i = 1, 3 do
		local lang = getElementData(thePlayer, "languages.lang" .. i)
		if lang and lang ~= 0 then
			local skill = getElementData(thePlayer, "languages.lang" .. i .. "skill")
			local langname = exports['language-system']:getLanguageName( lang )
			if langname then
				if isOverlayDisabled then
					outputChatBox("   - "..langname.." (" .. skill .. "%)", showPlayer)
				else
					table.insert(info, {"   - "..langname.." (" .. skill .. "%)"})
				end
			end
		end
	end
	--CAREER
	local job = getElementData(thePlayer, "job") or 0
	if job == 0 then
		if isOverlayDisabled then
			outputChatBox(" Carrera: Desempleado", showPlayer)
		else
			table.insert(info, {" Carrera: Desempleado"})
		end
	else
		local jobName = exports["job-system"]:getJobTitleFromID(job)
		local joblevel = getElementData(thePlayer, "jobLevel") or 1
		local jobProgress = getElementData(thePlayer, "jobProgress") or 0
		if isOverlayDisabled then
			outputChatBox(" Carrera: "..jobName, showPlayer)
			outputChatBox("   - Nivel Habilidad: "..joblevel, showPlayer)
			outputChatBox("   - Progreso: "..jobProgress, showPlayer)
		else
			table.insert(info, {" Carrera: "..jobName})
			table.insert(info, {"   - Nivel Habilidad: "..joblevel})
			table.insert(info, {"   - Progreso: "..jobProgress})
		end
	end
	--CARRIED
	local carried = " Peso Cargado: "..("%.2f/%.2f" ):format( exports["item-system"]:getCarriedWeight( thePlayer ), exports["item-system"]:getMaxWeight( thePlayer ) ).." kg(s)"
	if isOverlayDisabled then
		outputChatBox( carried, showPlayer)
	else
		table.insert(info, {carried})
	end
	--FINANCE
	local currentGC = getElementData(thePlayer, "credits") or 0
	local bankmoney = getElementData(thePlayer, "bankmoney") or 0
	local money = getElementData(thePlayer, "money") or 0
	if isOverlayDisabled then
		outputChatBox( " Finanza: ", showPlayer)
		outputChatBox( "   - GCs: "..exports.global:formatMoney(currentGC), showPlayer)
		outputChatBox( "   - Dinero: $"..exports.global:formatMoney(money), showPlayer)
		outputChatBox( "   - Dinero Banco: $"..exports.global:formatMoney(bankmoney), showPlayer)
	else
		table.insert(info, {" Finanza: "})
		table.insert(info, {"   - GCs: "..exports.global:formatMoney(currentGC)})
		table.insert(info, {"   - Dinero: $"..exports.global:formatMoney(money)})
		table.insert(info, {"   - Dinero Banco: $"..exports.global:formatMoney(bankmoney)})
	end
	
	if not isOverlayDisabled then
		triggerClientEvent(showPlayer, "hudOverlay:drawOverlayTopRight", showPlayer, info ) 
	end
end
addCommandHandler("stats", showStats, false, false)
addEvent("showStats", true)
addEventHandler("showStats", root, showStats)
