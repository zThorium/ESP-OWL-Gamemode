local fireModel = 2023
local isFireOn = false

local fireTable = {
		--  { x, y, z, "Location", "Incident description", "special or regular", carID(or blank) }
		{ 2116.5451660156, -1790.5614013672, 14.370749473572, "Los Santos, Idlewood Pizza Stack", "Hay humo saliendo de este contenedor, parece que se va a incendiar!", "regular" },
		{ 1892.892578125,-1800.7572021484, 15.758026123047, "Los Santos, Antigua Gasolinera de Idlewood", "¡Algunos tontos estaban jugando con un aerosol y un encendedor, prendieron fuego a este contenedor!", "regular" },
		{ 1858.4833984375,-1454.541015625, 13.395030975342, "Los Santos, junto al Skate Park", "Esta furgoneta acaba de esquivar una bicicleta y chocó contra la pared, su auto está echando humo. ¡Por favor, ayuda!", "special", 414 },
		{ -76.41796875, -1593.662109375, 2.6171875, "Intersección de Flint, parque de casas móviles en el suroeste de LS.", "Hay humo saliendo de un parque de casas móviles... ¡deberían revisar esto!", },
		{ 1706.869140625,-546.01953125,35.386379241943, "Condado Rojo, Autopista 25", "Este avión acaba de aterrizar en la carretera, ¡su motor está echando humo!", "regular", 513 },
		{ 2499.7451171875,-1670.771484375,13.348224639893, "Los Santos, Grove Street", "Este buggy de dunas acaba de correr por la calle y luego el motor explotó, hay mucho humo negro y se ve fuego", "regular", 568 },
		{ 2713.423828125,-2049.33984375,13.4275598526, "Los Santos, South Street - Playa Del Seville, cerca de Sun Street", "Uno de nuestros camiones acaba de salir de nuestra planta química y se incendió, hay productos químicos en ese camión. ¡Vengan rápido!", "special", 573 },
		{ 1873.32421875,-2497.193359375,13.5546875, "Los Santos International, Pista A!", "Tenemos un aterrizaje de emergencia, el motor del avión está fallando y está a punto de prenderse fuego. ¡Necesitamos un motor aquí rápidamente!", "regular", 577 },
		{ 2295.1318359375, -1693.37109375, 13.517011642456, "El callejón detrás de Ganton Gym!", "Algunas personas acaban de salir corriendo del callejón. Puedo ver humo!", "regular", 516 },
		{ 1961.8642578125, -1955.6796875, 13.751493453979, "Vías del tren de El Corona", "Uno de nuestros trenes ha reportado olor a humo debajo del tren. Nos gustaría que alguien lo verificara antes de que empeore.", "special", 538 },
		{ 1021.109375, -1916.8505859375, 12.66853427887, "Puestos del mercado al sur del DMV.", "¡Alguien derribó la barbacoa y prendió fuego al puesto, el fuego no es enorme, pero no tenemos nada para apagarlo!", "regular", },
		{ 1303.5419921875, 173.9775390625, 20.4609375, "Montgomery Trailer Park, en el lado sur.", "Unos niños acaban de prender fuego a la basura, se ha extendido a los árboles.", "regular", },
		{ 2161.294921875, -99.8544921875, 2.75, "La pequeña playa, lado oeste de Palamino Creek.", "Algún cobertizo está en llamas. Bastante grande.", "regular", },
		{ 2352.0224609375, -650.1396484375, 128.0546875, "North Rock.", "Fogata que salió mal, se ha extendido a la choza de madera.", "regular", },
		{ 1874.126953125, -1313.33203125, 14.500373840332, "El sitio de construcción en el lado norte del Skate Park.", "Incendio de estructura.", "regular", 524 },
		{ 2116.5451660156, -1790.5614013672, 14.370749473572, "Los Santos, Idlewood Pizza Stack", "Hay humo saliendo de este basurero, parece que se va a incendiar!", "regular", },
		{ 1892.892578125, -1800.7572021484, 15.758026123047, "Los Santos, Antigua Gasolinera de Idlewood", "¡Algunos tontos estaban jugando con un aerosol y un encendedor, prendieron fuego a este contenedor!", "regular", },
		{ 1858.4833984375, -1454.541015625, 13.395030975342, "Los Santos, junto al Skate Park", "Esta furgoneta acaba de esquivar una bicicleta y chocó contra la pared, su auto está echando humo. ¡Por favor, ayuda!", "special", 414 },
		{ -76.41796875, -1593.662109375, 2.6171875, "Intersección de Flint, parque de casas móviles LS suroeste.", "Hay humo saliendo de un parque de casas móviles... ¡deberían revisar esto!" },
		{ 1706.869140625, -546.01953125, 35.386379241943, "Condado Rojo, Autopista 25", "Este avión acaba de aterrizar en la carretera, ¡su motor está echando humo!", "regular", 513 },
		{ 2499.7451171875, -1670.771484375, 13.348224639893, "Los Santos, Grove Street", "Este buggy de dunas acaba de correr por la calle y luego el motor explotó, hay mucho humo negro y se ve fuego", "regular", 568 },
		{ 2713.423828125, -2049.33984375, 13.4275598526, "Los Santos, South Street - Playa Del Seville, cerca de Sun Street", "Uno de nuestros camiones acaba de salir de nuestra planta química y se incendió, hay productos químicos en ese camión.. ¡Vengan rápido!", "special", 573 },
		{ 1873.32421875, -2497.193359375, 13.5546875, "Los Santos International, Pista A!", "Tenemos un aterrizaje de emergencia, el motor del avión está fallando y está a punto de prenderse fuego. ¡Necesitamos un motor aquí rápidamente!", "regular", 577 },
		{ 595.06, -535.41, 17, "Dillimore, detrás del Edificio de la Policía.", "Hay un vehículo echando humo, ¡posiblemente esté a punto de incendiarse!", "regular", 401 },
		{ 658.0908, -439.372, 16, "Dillimore, los contenedores detrás del bar en el norte!", "¡Intentamos apagarlo y no funciona! ¡Están ardiendo!" },
		{ -76.41796875, -1593.662109375, 2.6171875, "Intersección de Flint, parque de casas móviles LS suroeste.", "Hay humo saliendo de un parque de casas móviles... ¡deberían revisar esto!" },
		{ 2351.08984375, -653.4462890625, 128.0546875, "North Rock, la choza en la cima de la colina!", "No estoy seguro, pero vale la pena revisarlo. ¡Hay mucho humo saliendo de allí!", "special", 410 },
		{ 2626.9677734375, -846.2607421875, 84.179885864258, "North Rock, junto a una choza en la colina!", "¡Un árbol acaba de incendiarse, maldito sol de California!" },
		{ 2859.03515625, -598.166015625, 10.928389549255, "Interstate 425 East, junto a la autopista.", "Un automóvil parece estar muy dañado, echando humo, ¡y hay un incendio junto a él! ¡Rápido!", "regular", 420 },
		{ 392.51171875, -1924.5078125, 10.25, "Muelle de Santa Monica.", "¡Uno de los edificios de madera se incendió!", "special" },
		{ -104.0712890625, -331.7822265625, 1.4296875, "Condado Rojo, almacén de arándanos.", "No estoy seguro de qué golpeó al tanque, ¡pero siento que pronto saldrá fuego!", "regular", 403 },
		{ 90.162109375, -286.1953125, 1.578125, "Condado Rojo, almacén de arándanos.", "No estoy seguro de qué golpeó al tanque, ¡pero siento que pronto saldrá fuego!", "regular", 403 },
		{ 1368.8466796875, -291.900390625, 1.7080450057983, "Canal de Mulholland!", "¡Un skimmer acaba de estrellarse aquí junto a la playa!", "regular", 460 },
}

function loadthescript()
    outputDebugString("LeFire Script loaded ...")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadthescript)

function fdfire()
    math.randomseed(getTickCount())
    local randomfire = math.random(1,#fireTable)
    local fX, fY, fZ = fireTable[randomfire][1],fireTable[randomfire][2],fireTable[randomfire][3]
            local playersOnFireTeam = exports.factions:getPlayersInFaction(2)
            for k, v in ipairs (playersOnFireTeam) do
                outputChatBox("[RADIO] Esto es despacho. Recibimos una llamada anónima sobre un incidente importante..",v,245, 40, 135)
				outputChatBox("[RADIO] El incidente es el siguiente: "..fireTable[randomfire][5],v,245, 40, 135)
                outputChatBox("[RADIO] Ubicación: "..fireTable[randomfire][4].." Por favor informe allí de inmediato. Agregamos una señal en tu GPS.",v,245, 40, 135)
            end

            -- You can get table info like this below, i set the variable above to make it shorter to call from.
            --outputDebugString("x:"..fireTable[randomfire][1].." y:"..fireTable[randomfire][2].." z:"..fireTable[randomfire][3])
			if (fireTable[randomfire][7]) then
				local fireveh = createVehicle(fireTable[randomfire][7], fX, fY, fZ)
				setTimer( function ()
					destroyElement(fireveh)
				end, 1800000, 1)
				blowVehicle(fireveh)
			end
			if (fireTable[randomfire][6] == "special") then
				local fireElem1 = createObject(fireModel,fX+2,fY+2,fZ)
				setElementCollisionsEnabled(fireElem,false)
				local col1 = createColSphere(fX+2,fY+2,fZ+1,2)
				setTimer ( function ()
					destroyElement(fireElem1)
					destroyElement(col1)
				end, 420000, 1)

				local fireElem2 = createObject(fireModel,fX+4,fY+4,fZ+2)
				setElementCollisionsEnabled(fireElem,false)
				local col2 = createColSphere(fX+4,fY+4,fZ+2,2)
				setTimer ( function ()
					destroyElement(fireElem2)
					destroyElement(col2)
				end, 420000, 1)

				local fireElem3 = createObject(fireModel,fX-2,fY-2,fZ)
				setElementCollisionsEnabled(fireElem,false)
				local col3 = createColSphere(fX-2,fY-2,fZ+1,2)
				setTimer ( function ()
					destroyElement(fireElem3)
					destroyElement(col3)
				end, 420000, 1)

				local fireElem4 = createObject(fireModel,fX-4,fY-4,fZ+2)
				setElementCollisionsEnabled(fireElem,false)
				local col4 = createColSphere(fX-4,fY-4,fZ+1,2)
				setTimer ( function ()
					destroyElement(fireElem4)
					destroyElement(col4)
				end, 420000, 1)

				local fireElem5 = createObject(fireModel,fX,fY-4,fZ+2)
				setElementCollisionsEnabled(fireElem,false)
				local col5 = createColSphere(fX,fY-4,fZ+1,2)
				setTimer ( function ()
					destroyElement(fireElem5)
					destroyElement(col5)
				end, 420000, 1)

				local fireElem6 = createObject(fireModel,fX-4,fY,fZ+2)
				setElementCollisionsEnabled(fireElem,false)
				local col6 = createColSphere(fX-4,fY,fZ+1,2)
				setTimer ( function ()
					destroyElement(fireElem6)
					destroyElement(col6)
				end, 420000, 1)
			end
            outputDebugString(fX.." "..fY.." "..fZ)
			-- Fire sync
			local fireElem = createObject(fireModel,fX,fY,fZ)
			setElementCollisionsEnabled(fireElem,false)
			local col = createColSphere(fX,fY,fZ+1,2)
			setTimer ( function ()
				destroyElement(fireElem)
				destroyElement(col)
			end, 420000, 1)


            triggerClientEvent("startTheFire", getRootElement(),fX,fY,fZ)
            local blip = createBlip(fX,fY,fZ, 43, 0, 0, 0, 255)
            setTimer ( function ()
                destroyElement(blip)
            end, 900000, 1)

			isFireOn = true
			setTimer ( function ()
				isFireOn = false
			end, 900000, 1)
end

-- /randomfire - Start a random fire from the table
function randomfire (thePlayer)
	if ( exports.integration:isPlayerTrialAdmin ( thePlayer ) ) then
		outputDebugString(isFireOn)
		if (isFireOn) then
			outputChatBox ("AdmCMD: Ya hay un incendio. Utilice /cancelfire o espere 30 minutos.", thePlayer,255,0,0)
		else
			fdfire()
			outputChatBox ("AdmCMD: ¡Has provocado un incendio aleatorio para FD!", thePlayer,255,0,0)
			outputChatBox ("AdmCMD: ¡Escribe /cancelfire para cancelarlo!", thePlayer,255,0,0)
		end
	end
end
addCommandHandler("randomfire", randomfire)

-- /cancelfire - Stops the whole fire process (restarts the resource)
function cancelrandomfire (thePlayer)
	if ( exports.integration:isPlayerTrialAdmin ( thePlayer ) ) then
		outputDebugString(isFireOn)
		if (isFireOn) then
			local thisResource = getThisResource()
			outputChatBox ("AdmCMD: ¡Has detenido el fuego aleatorio para FD!", thePlayer,255,0,0)
			outputChatBox ("AdmCMD: Pueden pasar hasta cinco minutos antes de que se cancele por completo.", thePlayer,255,0,0)
			restartResource(thisResource)
			isFireOn = false
		else
			outputChatBox ("AdmCMD: No se ha iniciado ningún incendio. Usa /randomfire para iniciarlo.", thePlayer,255,0,0)
		end
	end
end
addCommandHandler("cancelfire", cancelrandomfire)
