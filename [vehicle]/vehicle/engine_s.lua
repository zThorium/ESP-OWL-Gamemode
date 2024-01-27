--[[
* ***********************************************************************************************************************
* Copyright (c) 2015 OwlGaming Community - All Rights Reserved
* All rights reserved. This program and the accompanying materials are private property belongs to OwlGaming Community
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* ***********************************************************************************************************************
]]

local function batteryExceptions( veh )
	return ( ( getElementData(veh, 'job') or 0 ) ~= 0 ) or getVehicleType( veh ) == 'Plane'
end

local startings = { }
function startEngine( players, veh )
	if not startings[ veh ] or getTickCount() - startings[ veh ] > 5000 then
		startings[ veh ] = getTickCount()
		-- we need to determine if the engine is going to start or not first.
		local status = 'ok'
		if ( ( getElementData( veh, 'battery' ) or 100 ) > 0 ) or batteryExceptions( veh ) then
			-- has a bomb inside vehicle, blow it up.
			if exports.global:hasItem( veh, 74 ) then
				status = 'bomb'
			elseif ( getElementData( veh, 'enginebroke' ) or 0 ) == 1 then
				status = 'enginebroke'
			elseif ( getElementData( veh, "fuel") or 0 ) == 0 then
				status = 'nofuel'
			elseif getElementData(veh, "hotwired") then
				status = 'hotwired'
			else
				status = 'ok'
			end
		else
			exports.hud:sendBottomNotification( client, exports.global:getVehicleName( veh ), "Batería agotada." )
			triggerEvent('sendAme', client, "intenta arrancar el motor pero no lo consigue.")
			status = 'nobatt'
			return
		end

		if status == 'ok' then
			local vehID = getElementData(veh, "dbid")
			toggleControl( client, 'accelerate', true )
			toggleControl( client, 'brake_reverse', true )
			setVehicleEngineState( veh , true )
			exports.anticheat:setEld( veh, "engine", 1 )
			exports.anticheat:setEld( veh, "vehicle:radio", tonumber(getElementData(veh, "vehicle:radio:old")), 'all' )

			if exports.global:hasItem(client, 3, vehID) and exports.global:hasSpaceForItem(veh, 3, vehID) then -- Take key and place in vehicle
				exports.global:takeItem(client, 3, vehID)
				exports.global:giveItem(veh, 3, vehID)
			end

			-- inactivity scanner stuff
			local vid = getElementData( veh, 'dbid' )
			if vid > 0 then
				exports.anticheat:setEld( veh, "lastused", exports.datetime:now(), 'all' )
				dbExec( exports.mysql:getConn('mta'), "UPDATE vehicles SET lastUsed=NOW() WHERE id=? ", vid )
			end

			-- logs
			exports.vehicle_manager:addVehicleLogs( vid , "Started engine", client )
			exports.logs:dbLog( client, 31, { veh, client } , "STARTED ENGINE" )
		elseif status == 'hotwired' then 
			local vehID = getElementData(veh, "dbid")
			toggleControl( client, 'accelerate', true )
			toggleControl( client, 'brake_reverse', true )
			setVehicleEngineState( veh , true )
			exports.anticheat:setEld( veh, "engine", 1 )
			exports.anticheat:setEld( veh, "vehicle:radio", tonumber(getElementData(veh, "vehicle:radio:old")), 'all' )

			-- inactivity scanner stuff
			local vid = getElementData( veh, 'dbid' )
			if vid > 0 then
				exports.anticheat:setEld( veh, "lastused", exports.datetime:now(), 'all' )
				dbExec( exports.mysql:getConn('mta'), "UPDATE vehicles SET lastUsed=NOW() WHERE id=? ", vid )
			end

			triggerEvent('sendAme', client, "se agacha y hace saltar algunos cables.")

			-- logs
			exports.vehicle_manager:addVehicleLogs( vid , "Arranque del motor mediante el método de puentear debido a que ya estaba configurado como puenteable por un administrador..", client )
			exports.logs:dbLog( client, 31, { veh, client } , "STARTED ENGINE THAT WAS ALREADY HOTWIRED" )
		else
			-- play starting sound while we're doing it.
			for i, player in pairs( players ) do
				triggerClientEvent( player, 'vehicle:engine:start:sound', resourceRoot, veh, 'sounds/engine_start.mp3' )
			end

			setTimer(function (client)
				-- have battery or is a job vehicle.
				if status == 'bomb' then
					-- stop the sound.
					for i, player in pairs( players ) do
						triggerClientEvent( player, 'vehicle:engine:start:sound', resourceRoot, veh, false )
					end

					while exports.global:hasItem(veh, 74) do
						exports.global:takeItem(veh, 74)
					end
					blowVehicle(veh)
				elseif status == 'enginebroke' then
					exports.hud:sendBottomNotification( client, exports.global:getVehicleName( veh ), "El motor está roto." )
					triggerEvent('sendAme', client, "intenta arrancar el motor pero no lo consigue.")
				elseif status == 'nofuel' then
					exports.hud:sendBottomNotification( client, exports.global:getVehicleName( veh ), "FEl depósito de combustible está vacío.." )
					triggerEvent('sendAme', client, "intenta arrancar el motor pero no lo consigue.")
				end
			end, 1500, 1, client)
		end
	end
end
addEvent( 'vehicle:engine:start', true )
addEventHandler( 'vehicle:engine:start', resourceRoot, startEngine )

function stopEngine( veh )
	local vehID = getElementData(veh, "dbid")
	setVehicleEngineState( veh, false )
	exports.anticheat:setEld( veh, 'engine', 0 )

	if exports.global:hasItem(veh, 3, vehID) and exports.global:hasSpaceForItem(client, 3, vehID) then
		exports.global:takeItem(veh, 3, vehID)
		exports.global:giveItem(client, 3, vehID)
	end
end
addEvent( 'vehicle:engine:stop', true )
addEventHandler( 'vehicle:engine:stop', resourceRoot, stopEngine )

-- this is a workaround to fix an issue that GTA always turn on engine when player get in a vehicle.
function setEngineStatusOnEnter( enteringPlayer, seat, jacked )
	if seat == 0 and not enginelessVehicle[ getElementModel(source) ] then
		local engineRunning = ( getElementData( source, 'engine' ) or 0 ) == 1 and ( getElementData( source, 'enginebroke' ) or 0 ) == 0
		if getElementType(enteringPlayer) == "player" then
			toggleControl( enteringPlayer, 'accelerate', engineRunning )
			toggleControl( enteringPlayer, 'brake_reverse', engineRunning )
		end
		setVehicleEngineState( source , engineRunning )
	end
end
addEventHandler("onVehicleEnter", root , setEngineStatusOnEnter)
