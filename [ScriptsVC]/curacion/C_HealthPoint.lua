----------------------------------------
-- Name: Health Point / Ponto de Cura --
-- 			SIDE: Client 			  --
--        Autor: #Tasi, MrDante 	  --
----------------------------------------

local szx,szy = guiGetScreenSize()
local screenSource = dxCreateScreenSource(szx, szy)
local Shader = dxCreateShader("gfx/Blackwhite.fx")
local relposx = szx/2
local medX = szx/2
local ancho = -3780
local sizeX = ancho/3
local mitSize = sizeX*0.5
local botX = medX-mitSize
local relposx = szy/2
local medX2 = szy/2
local ancho2 = -2160
local sizeX2 = ancho2/3
local mitSize2 = sizeX2*0.5
local botX2 = medX2-mitSize2
local correctX, correctY = botX+sizeX, botX2+sizeX2
local mainFont = dxCreateFont("gfx/Swansea.ttf", 10)
local mainFont2 = dxCreateFont("gfx/OpenSans.ttf", 12)
local pickups = { pickup = { } }

addEventHandler ( "onClientResourceStart", resourceRoot,
	function()
		for _, v in ipairs ( Positions )    do
		local tx, ty, tz = unpack ( v )
			pickups.pickup[v] = createMarker ( tx, ty, tz-1.5, "corona", 4, 255, 140, 0, 0 )
			addEventHandler("onClientMarkerHit", pickups.pickup[v], onMarkerHit)
			addEventHandler("onClientMarkerLeave", pickups.pickup[v], onMarkerLeave)
		end
	end
)

function onMarkerHit (hitElement)
	if getElementType(hitElement) == "player" and hitElement == getLocalPlayer() then
		addCommandHandler ( "emergencia", openLife )
		addEventHandler("onClientRender", root, presse)
	end
end

function onMarkerLeave (hitElement)
	if getElementType(hitElement) == "player" and hitElement == getLocalPlayer() then
		addCommandHandler ( "emergencia", openLife )
		removeEventHandler("onClientRender", root, presse)
	end
end 

variableLife = false
function presse ()
	dxDrawRectangle(correctX+490, correctY+550, 280, 80, tocolor(0, 0, 0, 100))
	dxDrawLineRect(correctX+490, correctY+550, 280, 80, tocolor(0, 0, 0, 255))
	dxDrawImage ( correctX+500, correctY+560, 50, 50, "gfx/healthpoint.png" )
	dxDrawText("Escribe #FFAA00/emergencia #ffffffPara curarte!",correctX+550, correctY+580, 30, 30, tocolor(255, 255, 255, 255), 1.00, mainFont, "left", "top", false, false, false, true, false)
end

function renderLife()
	dxDrawRectangle(correctX+435, correctY+270, 390, 120, tocolor(0, 0, 0, 150))
	dxDrawRectangle(correctX+482, correctY+324, 293, 17, tocolor(0, 0, 0, 150))
	dxDrawRectangle(correctX+482, correctY+324, 293 / getPedMaxHealth(getLocalPlayer()) * math.floor(getElementHealth(getLocalPlayer()) + 0.40000152596), 17, tocolor(255, 170, 0, 250))
	dxDrawRectangle(correctX+575, correctY+350, 115, 20, isCursorOnElement(correctX+575, correctY+350, 115, 20) and tocolor(255, 170, 0, 255) or tocolor(0, 0, 0, 100))
	dxDrawLineRect(correctX+435, correctY+270, 390, 120, tocolor(0, 0, 0, 255))
	dxDrawLineRect(correctX+482, correctY+324, 293, 17, tocolor(0, 0, 0, 255))
	dxDrawLineRect(correctX+575, correctY+350, 115, 20, tocolor(0, 0, 0, 255))
	dxDrawText("Recargar vida", correctX+580, correctY+350, 30, 30, tocolor(255, 255, 255, 255), 1.00, mainFont2, "left", "top", false, false, false, true, false)
	dxDrawText("Es Gratis ! , Pero lleva tiempo", correctX+500, correctY+300, 30, 30, tocolor(255, 255, 255, 255), 1.00, mainFont, "left", "top", false, false, false, true, false)
	dxDrawText(math.floor(getElementHealth(getLocalPlayer()) + 0.40000152596).."/100", correctX+600, correctY+323, 30, 30, tocolor(255, 255, 255, 255), 1.00, mainFont, "left", "top", false, false, false, true, false)
	dxDrawImage ( correctX+450, correctY+290, 50, 50,"gfx/healthpoint.png" )
	dxDrawImage(correctX+800, correctY+275, 20, 20, isCursorOnElement(correctX+800, correctY+275, 20, 20) and "gfx/close2.png" or "gfx/close1.png")
end


function shaderFx()
	dxSetShaderValue(Shader, "ScreenSource", screenSource);
	dxUpdateScreenSource( screenSource );
	dxDrawImage(0, 0, szx, szy, Shader)

	dxDrawRectangle(correctX+435, correctY+270, 390, 120, tocolor(0, 0, 0, 100))
	dxDrawRectangle(correctX+482, correctY+324, 293, 17, tocolor(0, 0, 0, 100))
	--dxDrawRectangle(correctX+575, correctY+350, 115, 20, isCursorOnElement(correctX+575, correctY+350, 115, 20) and tocolor(255, 170, 0, 255) or tocolor(0, 0, 0, alpha))
	dxDrawRectangle(correctX+482, correctY+324, 293 / getPedMaxHealth(getLocalPlayer()) * math.floor(getElementHealth(getLocalPlayer()) + 0.40000152596), 17, tocolor(255, 170, 0, 250))
	dxDrawLineRect(correctX+435, correctY+270, 390, 120, tocolor(0, 0, 0, 255))
	dxDrawLineRect(correctX+482, correctY+324, 293, 17, tocolor(0, 0, 0, 255))
	
	dxDrawImage ( correctX+413, correctY+250, 30, 30, "gfx/healthpoint.png" )
	dxDrawText(math.floor(getElementHealth(getLocalPlayer()) + 0.40000152596).."%", correctX+482, correctY+324, correctX+482+293, correctY+324+17, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, true, false)
	dxDrawImage(correctX+800, correctY+275, 20, 20, isCursorOnElement(correctX+800, correctY+275, 20, 20) and "gfx/close2.png" or "gfx/close1.png")
end

function openLife()
	if variableLife == false then
		removeEventHandler("onClientRender", root, presse)
		showCursor(true)
		variableLife = true
		addEventHandler("onClientRender", root, renderLife)
	else
		variableLife = false
		removeEventHandler("onClientRender", root, renderLife)
		showCursor(false)
	end
end


function setPedHealth(_, state)
	if variableLife == true then
		if state == "down" then
			if isCursorOnElement(correctX+575, correctY+350, 115, 20) then
				if getElementHealth(getLocalPlayer()) < 100 then
					setElementFrozen(getLocalPlayer(), true)
					sound = playSound("sfx/health.mp3", true)
					theTimer = setTimer(function()
						if getElementHealth(getLocalPlayer()) >= 100 then
							removeEventHandler("onClientRender", root, renderLife)
							removeEventHandler("onClientRender", root, shaderFx)
							setElementFrozen(getLocalPlayer(), false)
							showCursor(false)
							variableLife = false
							stopSound(sound)
							killTimer(theTimer)
							return 
						end
						setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer()) + 0.2)
					end, 300, 0)
					addEventHandler("onClientRender", root, shaderFx)
					removeEventHandler("onClientRender", root, renderLife)
				elseif getElementHealth(getLocalPlayer()) >= 100 then
					variableLife = false
					removeEventHandler("onClientRender", root, renderLife)
					removeEventHandler("onClientRender", root, shaderFx)
					setElementFrozen(getLocalPlayer(), false)
					showCursor(false)
				end
			elseif isCursorOnElement(correctX+800, correctY+275, 20, 20) then
				if (isTimer(theTimer)) then
					killTimer(theTimer)
					stopSound(sound)
				end
				variableLife = false
				removeEventHandler("onClientRender", root, renderLife)
				removeEventHandler("onClientRender", root, shaderFx)
				setElementFrozen(getLocalPlayer(), false)
				showCursor(false)
			end
		end
	end
end
addEventHandler("onClientClick", root, setPedHealth)

addEventHandler ( "onClientRender", root,
	function ()
		for _, v in pairs ( pickups.pickup ) do
	        local vx, vy, vz = getElementPosition(v)
	        local scX, scY = getScreenFromWorldPosition(vx, vy, vz+3.5)
	        local cx,cy,cz,clx,cly,clz,crz,cfov = getCameraMatrix()
	        local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz+3.5)
	        if scX then
				local largura, altura = 165, 90
	            local Tx = scX-(1000/dist)*szx/800/largura*cfov
	            local Ty = scY-(100/dist)*szy/600/altura*cfov
	            local Tw = (1000/dist)*szx/400/largura*cfov
	            local Th = (1000/dist)*szy/400/altura*cfov
				if dist < 80.0 then
					if (isLineOfSightClear(cx, cy, cz, vx, vy, vz+1.5, true, false, false)) then
						if not isElementWithinMarker(localPlayer, v) then
							dxDrawImage ( Tx, Ty, Tw, Th, "gfx/healthpoint.png" )
						end
					end
				end
			end
		end	
	end
)