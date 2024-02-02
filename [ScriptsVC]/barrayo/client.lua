local players = { }
local font_yo = dxCreateFont( "tajoma.ttf", 8 )

function dibujaryo()
	local lx, ly, lz = getElementPosition( localPlayer )
	local jugadores = getElementsByType( "player" )
	for k, v in ipairs(jugadores) do
		local x, y, z = getElementPosition( v )
		local dist =  getDistanceBetweenPoints3D( lx, ly, lz, x, y, z )
		local yo = getElementData( v, "yo" ) or ""
		if dist < 12 then
		if isLineOfSightClear( lx, ly, lz, x, y, z, true, false, false, true, false, false, false, localPlayer ) then
			local bone = { getPedBonePosition( v, 1 ) }
			local c = { getScreenFromWorldPosition( bone[1], bone[2], bone[3]+0.3 ) }
				if c[1] and c[2] then
					dxDrawText(yo, c[1], c[2]+38, c[1], c[2], tocolor(0,0,0,255), 1, "default-bold", "center", "center")
					dxDrawText(yo, c[1], c[2]+37, c[1], c[2], tocolor(255, 0,0,255), 1, "default-bold", "center", "center")
				end
			end
		end
	end
end
addEventHandler("onClientRender", getRootElement(), dibujaryo)