local playerInjuries = {} -- create a table to save the injuries

function copy( t )
	local r = {}
	if type(t) == 'table' then
		for k, v in pairs( t ) do
			r[k] = v
		end
	end
	return r
end

function isMelee( weapon )
	return weapon and weapon <= 15
end

function killknockedout(source)
	setElementHealth(source, 0)
end

function knockout()
	if playerInjuries[source] and not isTimer( playerInjuries[source]['knockout'] ) then
		outputChatBox("¡Has sido noqueado!", source, 255, 0, 0)
		toggleAllControls(source, false, true, false)
		--fadeCamera(source, false, 120)
		playerInjuries[source]['knockout'] = setTimer(killknockedout, 120000, 1, source)
		
		exports.global:applyAnimation( source, "CRACK", "crckidle2", -1, true, false, true)
		exports.anticheat:changeProtectedElementDataEx(source, "injuriedanimation", true, false)
		executeCommandHandler('ame', source, "ha sido noqueado.")
	end
end

function injuries(attacker, weapon, bodypart, loss)
	-- paintball
	if getElementData(source, "paintball") and getElementData(source, "paintball") == 2 then
		return
	end
	
	if not loss or loss < 0.5 then
		return
	end
	
	-- drowning
	if weapon == 53 then
		return
	end
	
	-- source = player who was hit
	if not bodypart and getPedOccupiedVehicle(source) then
		bodypart = 3
	end
	
	-- BODY ARMOR
	if bodypart == 3 and getPedArmor(source) > 0 then -- GOT (torso) PROTECTION?
		cancelEvent()
		return
	end

	-- katana 25% kill
	if weapon == 8 then
		if math.random( 1, 4 ) == 1 then
			setPedHeadless(source, true)
			killPed(source, attacker, weapon, bodypart)
			return
		end
	end

	--[[
	-- 25% chance of melee knockout
	if isMelee( weapon ) then
		if math.random( 1, 4 ) == 1 then
			knockout()
		end
		return
	end
	]]
	
	-- if we have injuries saved for the player, we add it to their table
	local injuredBefore = copy( playerInjuries[source] )
	if playerInjuries[source] then
		playerInjuries[source][bodypart] = true
	else
		-- create a new table for that player
		playerInjuries[source] = { [bodypart] = true } -- table
	end
	
	if ( bodypart == 3 and loss >= 15 ) or bodypart == 7 or bodypart == 8 then -- damaged either left or right leg
		if bodypart == 3 then
			bodypart = math.random( 7, 8 )
			playerInjuries[source][bodypart] = true
		end

		if playerInjuries[source][7] and playerInjuries[source][8] then -- both were already hit
			toggleControl(source, 'forwards', false) -- disable walking forwards for the player who was hit
			toggleControl(source, 'left', false)
			toggleControl(source, 'right', false)
			toggleControl(source, 'backwards', false)
			toggleControl(source, 'enter_passenger', false)
			toggleControl(source, 'enter_exit', false)
		end
		
		-- we can be sure at least one of the legs was hit here, since we checked it above
		toggleControl(source, 'sprint', false) -- disable running forwards for the player who was hit
		toggleControl(source, 'jump', false) -- tried jumping with broken legs yet?
		
		executeCommandHandler('ame', source, "pierna " .. ( bodypart == 7 and "izquierda" or "derecha" ) .. " fue golpeada.")
	elseif bodypart == 5 or bodypart == 6 then -- damaged either arm
		if playerInjuries[source][5] and playerInjuries[source][6] then -- both were already hit
			toggleControl(source, 'fire', false) -- disable firing weapons for the player who was hit
		end

		toggleControl(source, 'aim_weapon', false) -- disable aiming for the player who was hit (can still fire, but without crosshair)
		toggleControl(source, 'jump', false) -- can't climb over the wall with a broken arm

		executeCommandHandler('ame', source, "'s " .. ( bodypart == 5 and "izquierda" or "derecha" ) .. " el brazo fue golpeado.")
	elseif bodypart == 3 then
		if not weapon == 17 then
			executeCommandHandler('ame', source, " torso fue golpeado", source)
		end
	elseif bodypart == 9 then -- headshot
		if (weapon >= 22 and weapon <=38) then
			local tazer
			if weapon == 24 then
				if attacker and getElementData(attacker, "deaglemode") == 0 then
					tazer = true
				end
			end
			if not tazer then
				setPedHeadless(source, true)
				executeCommandHandler('ame', source, " la cabeza fue volada.", source)
				killPed(source, attacker or source, weapon, bodypart)
				return
			end
		else
			doHeadHit(source)
			return
		end
	end
	--[[
	if ( getElementHealth(source) < 20 or ( isElement( attacker ) and getElementType( attacker ) == "vehicle" and getElementHealth(source) < 40 ) ) and math.random( 1, 3 ) <= 2 then
		knockout()
	end
	]]
end
addEventHandler( "onPlayerDamage", getRootElement(), injuries )

function doHeadHit(headHitPlayer)
	outputChatBox("You've been hit in the head!", headHitPlayer, 255, 0, 0)
	setElementHealth(headHitPlayer, math.max(0, getElementHealth(headHitPlayer) - 80))
	exports.global:applyAnimation( headHitPlayer, "CRACK", "crckidle2", -1, true, false, true)
	executeCommandHandler('ame', headHitPlayer, " cabeza fue golpeada.")
end
addEvent( "doHeadHit", true )
addEventHandler( "doHeadHit", getRootElement(), doHeadHit )

addCommandHandler( "fakeinjury",
	function(thePlayer, command, weapon, bodypart, loss)
		if exports.integration:isPlayerTrialAdmin(thePlayer) then
			source = thePlayer
			loss = tonumber(loss)
			setElementHealth(thePlayer, math.max(0, getElementHealth(thePlayer) - loss))
			injuries(nil, tonumber(weapon), tonumber(bodypart), loss)
		end
	end
)

function stabilize()
	if playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source]['knockout'] then
			exports.anticheat:changeProtectedElementDataEx(source, "injuriedanimation", false, false)
			if isTimer(playerInjuries[source]['knockout']) then
				killTimer(playerInjuries[source]['knockout'])
				playerInjuries[source]['knockout'] = nil
				
				--fadeCamera(source, true, 2)
				setPedAnimation(source)
				exports.global:removeAnimation(source)

				toggleControl(source, 'forwards', true)
				toggleControl(source, 'left', true)
				toggleControl(source, 'right', true)
				toggleControl(source, 'backwards', true)
				toggleControl(source, 'enter_passenger', true)
				setElementHealth(source, math.max( 20, getElementHealth(source) ) )
			end
		end
		
		if playerInjuries[source][7] and playerInjuries[source][8] then
			toggleControl(source, 'forwards', true)
			toggleControl(source, 'left', true)
			toggleControl(source, 'right', true)
			toggleControl(source, 'backwards', true)
			toggleControl(source, 'enter_passenger', true)
		end
	end
end

addEvent( "onPlayerStabilize", false )
addEventHandler( "onPlayerStabilize", getRootElement(), stabilize )

function examine(to)
    local name = getPlayerName(source):gsub("_", " ")

    if isPedDead(source) then
        outputChatBox(name .. " está muerto.", to, 255, 0, 0)
    elseif playerInjuries[source] and not isPedHeadless(source) then
        if playerInjuries[source]['knockout'] then
            outputChatBox(name .. " está noqueado.", to, 255, 255, 0)
        end

        if playerInjuries[source][7] and playerInjuries[source][8] then
            outputChatBox("Ambas piernas de " .. name .. " están rotas.", to, 255, 255, 0)
        elseif playerInjuries[source][7] then
            outputChatBox("La pierna izquierda de " .. name .. " está rota.", to, 255, 255, 0)
        elseif playerInjuries[source][8] then
            outputChatBox("La pierna derecha de " .. name .. " está rota.", to, 255, 255, 0)
        end

        if playerInjuries[source][5] and playerInjuries[source][6] then
            outputChatBox("Ambos brazos de " .. name .. " están rotos.", to, 255, 255, 0)
        elseif playerInjuries[source][5] then
            outputChatBox("El brazo izquierdo de " .. name .. " está roto.", to, 255, 255, 0)
        elseif playerInjuries[source][6] then
            outputChatBox("El brazo derecho de " .. name .. " está roto.", to, 255, 255, 0)
        end
    else
        outputChatBox(name .. " no está herido.", to, 255, 255, 0)
    end
end


addEvent( "onPlayerExamine", false )
addEventHandler( "onPlayerExamine", getRootElement(), examine )

function healInjuries(healed)
	if playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source]['knockout'] then
			exports.anticheat:changeProtectedElementDataEx(source, "injuriedanimation", false, false)
			if isTimer(playerInjuries[source]['knockout']) then
				killTimer(playerInjuries[source]['knockout'])
				playerInjuries[source]['knockout'] = nil
				
				if healed then
					--fadeCamera(source, true, 2)
					setPedAnimation(source)
					exports.global:removeAnimation(source)
				end
			end
			toggleAllControls(source, true, true, false)
		else
			if playerInjuries[source][7] and playerInjuries[source][8] then
				toggleControl(source, 'forwards', true) -- disable walking forwards for the player who was hit
				toggleControl(source, 'left', true)
				toggleControl(source, 'right', true)
				toggleControl(source, 'backwards', true)
				toggleControl(source, 'enter_passenger', true)
				toggleControl(source, 'enter_exit', true)
			end
			if playerInjuries[source][7] or playerInjuries[source][8] then
				toggleControl(source, 'sprint', true)
				toggleControl(source, 'jump', true)
			end
			
			if playerInjuries[source][5] and playerInjuries[source][6] then
				toggleControl(source, 'fire', true)
			end
			if playerInjuries[source][5] or playerInjuries[source][6] then
				toggleControl(source, 'aim_weapon', true)
				toggleControl(source, 'jump', true)
			end
		end
		playerInjuries[source] = nil
	end
end

addEvent( "onPlayerHeal", false ) -- add a new event for it (called from /heal)
addEventHandler( "onPlayerHeal", getRootElement(), healInjuries)

function restoreInjuries( )
	if playerInjuries[source] and not isPedHeadless(source) then
		if playerInjuries[source][7] and playerInjuries[source][8] then
			toggleControl(source, 'forwards', false)
			toggleControl(source, 'left', false)
			toggleControl(source, 'right', false)
			toggleControl(source, 'backwards', false)
			toggleControl(source, 'enter_passenger', false)
			toggleControl(source, 'enter_exit', false)
		end
		if playerInjuries[source][7] or playerInjuries[source][8] then
			toggleControl(source, 'sprint', false)
			toggleControl(source, 'jump', false)
		end
		
		if playerInjuries[source][5] and playerInjuries[source][6] then
			toggleControl(source, 'fire', false)
		end
		if playerInjuries[source][5] or playerInjuries[source][6] then
			toggleControl(source, 'aim_weapon', false)
			toggleControl(source, 'jump', false)
		end
	end
end
addEventHandler( "onPlayerStopAnimation", getRootElement(), restoreInjuries )

function resetInjuries() -- it actually has some parameters, but we only need source right now - the wiki explains them though
	setPedHeadless(source, false)

	if playerInjuries[source] then
		-- reset injuries
		healInjuries()
	end
end

addEventHandler( "onPlayerSpawn", getRootElement(), resetInjuries) -- make sure old injuries don't carry over
addEventHandler( "onPlayerQuit", getRootElement(), resetInjuries) -- cleanup when the player quits

function lvesHeal(thePlayer, commandName, targetPartialNick, price)
    if not (targetPartialNick) or not (price) then -- si falta el argumento del jugador objetivo
        outputChatBox("SINTAXIS: /" .. commandName .. " [Nombre Parcial / ID del Jugador] [Precio de la Curación]", thePlayer, 255, 194, 14)
    else
        local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialNick)
        if targetPlayer then -- ¿el jugador está en línea?
            local logged = getElementData(thePlayer, "loggedin")
    
            if (logged == 1) then
                if not (exports.factions:isInFactionType(thePlayer, 4)) then
                    outputChatBox("No tienes habilidades médicas básicas, contacta a Emergency Services.", thePlayer, 255, 0, 0)
                elseif (targetPlayer == thePlayer) then
                    outputChatBox("No puedes curarte a ti mismo.", thePlayer, 255, 0, 0)
                elseif (isPedDead(targetPlayer)) then
                    outputChatBox("¡Esta persona está muerta!", thePlayer, 255, 0, 0)
                else
                    price = tonumber(price)
                    if price > 500 then
                        outputChatBox("Es demasiado caro pedir eso.", thePlayer, 255, 0, 0)
                    else
                        local x, y, z = getElementPosition(thePlayer)
                        local tx, ty, tz = getElementPosition(targetPlayer)
                        
                        if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz) > 3) then -- ¿Están parados uno al lado del otro?
                            outputChatBox("Estás demasiado lejos para curar a '" .. targetPlayerName .. "'.", thePlayer, 255, 0, 0)
                        else
                            local foundkit, slot, itemValue = exports.global:hasItem(thePlayer, 70)
                            if (foundkit) then
                                local money = exports.global:getMoney(targetPlayer)
                                local bankmoney = getElementData(targetPlayer, "bankmoney")
                                
                                if money + bankmoney < price then
                                    outputChatBox("El jugador no puede pagar la curación.", thePlayer, 255, 0, 0)
                                else
                                    local takeFromCash = math.min(money, price)
                                    local takeFromBank = price - takeFromCash
                                    exports.global:takeMoney(targetPlayer, takeFromCash)
                                    if takeFromBank > 0 then
                                        exports.anticheat:changeProtectedElementDataEx(targetPlayer, "bankmoney", bankmoney - takeFromBank, false)
                                    end
                                    
                                    local tax = exports.global:getTaxAmount()
                                    
                                    exports.global:giveMoney(exports.factions:getFactionFromID(2), math.ceil((1 - tax) * price))
                                    exports.global:giveMoney(getTeamFromName("Government of Los Santos"), math.ceil(tax * price))
                                    
                                    setElementHealth(targetPlayer, 100)
                                    triggerEvent("onPlayerHeal", targetPlayer, true)
                                    outputChatBox("Has curado a '" .. targetPlayerName .. "'.", thePlayer, 0, 255, 0)
                                    outputChatBox("Has sido curado por '" .. getPlayerName(thePlayer) .. "' por $" .. price .. ".", targetPlayer, 0, 255, 0)
                                    exports.logs:dbLog(thePlayer, 35, targetPlayer, "CURACIÓN POR $" .. price)
                                    
                                    if itemValue > 1 then
                                        exports['item-system']:updateItemValue(thePlayer, slot, itemValue - 1)
                                    else
                                        exports.global:takeItem(thePlayer, 70, itemValue)
                                        if not exports.global:hasItem(thePlayer, 70) then
                                            outputChatBox("Advertencia, te has quedado sin botiquines médicos. Usa /duty para obtener nuevos.", thePlayer, 255, 0, 0)
                                        end
                                    end
                                end
                            else
                                outputChatBox("Necesitas un botiquín médico para curar a alguien.", thePlayer, 255, 0, 0)
                            end
                        end
                    end
                end
            end
        end
    end
end

addCommandHandler("curar", lvesHeal, false, false)

function lvesExamine(thePlayer, commandName, targetPartialNick)
    if not targetPartialNick then -- si falta el argumento del jugador objetivo
        outputChatBox("SINTAXIS: /" .. commandName .. " [Nombre Parcial / ID del Jugador]", thePlayer, 255, 194, 14)
    else
        local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialNick)
        if targetPlayer then -- ¿el jugador está en línea?
            local logged = getElementData(thePlayer, "loggedin")
    
            if logged == 1 then
                
                if not (exports.factions:isInFactionType(thePlayer, 4)) then
                    outputChatBox("No tienes habilidades médicas básicas, contacta a Emergency Services.", thePlayer, 255, 0, 0)
                else
                    local x, y, z = getElementPosition(thePlayer)
                    local tx, ty, tz = getElementPosition(targetPlayer)
                
                    if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz) > 5) then -- ¿Están parados uno al lado del otro?
                        outputChatBox("Estás demasiado lejos para examinar a '"..targetPlayerName.."'.", thePlayer, 255, 0, 0)
                    else
                        triggerEvent("onPlayerExamine", targetPlayer, thePlayer)
                    end
                end
            end
        end
    end
end
addCommandHandler("examinar", lvesExamine, false, false)
