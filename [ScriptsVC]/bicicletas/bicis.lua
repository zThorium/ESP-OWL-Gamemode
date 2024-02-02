local bicicletas = {
	
	-- Las Barrancas
	{2002.1462402344 ,-2275.5283203125, 14.42411613464, 0, 0, 6.1387023925781},
	{1999.1462402344 ,-2275.5283203125, 14.42411613464, 0, 0, 6.1387023925781},
	{1996.1462402344 ,-2275.5283203125, 14.42411613464, 0, 0, 6.1387023925781},
	{1993.1462402344 ,-2275.5283203125, 14.42411613464, 0, 0, 6.1387023925781},
	{1990.1462402344 ,-2275.5283203125, 14.42411613464, 0, 0, 6.1387023925781},
	{1987.1462402344 ,-2275.5283203125, 14.42411613464, 0, 0, 6.1387023925781},
	
	-- Fort Carson
	{1752.1923828125, -1866.3201904297, 13.57155418396, 0, 0, 356.3},
	{1754.2580566406, -1866.244140625, 13.571647644043, 0, 0, 356.3},
	{1756.642578125, -1866.1431884766, 13.57177066803, 0, 0, 356.3},
	{1755.6995849609, -1866.4216308594, 13.571430206299, 0, 0, 356.3},
	{-172.5810546875, 1000.9853515625, 19.395965576172, 359.46716308594, 359.99450683594, 90.675659179688},

}

local bici = {}

setTimer( function()
	for i=1, #bici do 
		if not getVehicleOccupant( bici[i] ) then
			respawnVehicle( bici[i] )
		end
	end
end, 3*60000, 0 )

addCommandHandler( "respawnbicis",
	function(p)
		if hasObjectPermissionTo( p, "command.spectate", false ) then
			for i=1, #bici do 
				if not getVehicleOccupant( bici[i] ) then
					respawnVehicle( bici[i] )
				end
			end			
			outputChatBox( "** Has respawneado las bicis. **", p, 0, 220, 145 )
		end
	end
)

function itsBicicleta(veh)
	for i=1, #bici do 
		if veh == bici[i] then
			return true
		end
	end
	return false
end

function enterVehicle ( player, seat, jacked )
	if itsBicicleta( source ) then
		toggleControl( player, "vehicle_fire", false )
		local tiempochar = exports.players:getCharTiempo( player )
		if ( tiempochar - getRealTime().timestamp ) < 0 then
			cancelEvent()
			outputChatBox( "Se te ha acabado el tiempo de uso de las bicicletas.", player, 255, 150, 0 )
		end
	else
		toggleControl( player, "vehicle_fire", true )
	end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle )

addEventHandler( "onResourceStart", resourceRoot,
	function()
		for i=1, #bicicletas do 
			bici[i] = createVehicle( 510, unpack( bicicletas[i] ) )
			setVehicleRespawnPosition( bici[i], unpack( bicicletas[i] ) )
			setVehicleHandling( bici[i], "engineInertia", 0.2 )
			setVehicleHandling( bici[i], "maxVelocity", 40 )
		end
	end
)

--[[addCommandHandler( "posveh",
	function( p )
		local veh = getPedOccupiedVehicle(p)
		if veh then
			local x, y, z = getElementPosition( veh )
			local rx, ry, rz = getElementRotation( veh )
			outputChatBox( "{"..x..", "..y..", "..z..", "..rx..", "..ry..", "..rz.."},", p )
		end
	end
)--]]