g_Me = getLocalPlayer()

if getElementData(localPlayer, "AFK") == false then
    TimerAFKstart = setTimer(function()
	setElementData(localPlayer,"AFK",true)
    end, 300000,0)
end

function outputPressedCharacter()
resetTimer(TimerAFKstart)
setElementData(localPlayer,"AFK",false)
end
addEventHandler("onClientCharacter", getRootElement(), outputPressedCharacter)

addEventHandler( "onClientCursorMove", getRootElement( ),
    function ( _, _, x, y )
        resetTimer(TimerAFKstart)
        setElementData(localPlayer,"AFK",false)
    end
);

function handleMinimize()
if getElementData(localPlayer,"AFK") == false then
setElementData (localPlayer, "AFK", true)
end
end
addEventHandler( "onClientMinimize", root, handleMinimize )

function handleRestore( didClearRenderTargets )
    if didClearRenderTargets then
    setElementData (localPlayer, "AFK", false)
	resetTimer(TimerAFKstart)
    end
end
addEventHandler("onClientRestore",root,handleRestore)

local sW,sH = guiGetScreenSize()

g_Me = getLocalPlayer()

function AFK()
    for i, player in ipairs(getElementsByType("player")) do
        if player ~= g_Me then
            if getElementData(player, "AFK") == true then 
            local x, y, z = getPedBonePosition( player, 6 )
            WorldPositionX, WorldPositionY = getScreenFromWorldPosition(x,y,z+0.6,0.0)
            Mx, My, Mz = getCameraMatrix()
                if (WorldPositionX and WorldPositionY) then
                    if (getDistanceBetweenPoints3D(x,y,z,Mx,My,Mz) <= 15 ) then
                        if not systemUpTime then
                        systemUpTime = getTickCount ()*0.001
	                    end
					currentCount = getTickCount ()*0.001
					Secs = math.floor(((currentCount - systemUpTime)*100)/100)
					Min = math.floor(((Secs/60)*100)/100)
					    if Secs >= 60 then
						Secs = math.floor(((currentCount - systemUpTime)*100)/100)-Min*60
					    end
	                Format = string.format("%02d:%02d", (Min), (Secs))
                    dxDrawBorderedText("AFK",WorldPositionX,WorldPositionY-68,WorldPositionX,WorldPositionY,tocolor(200,15,15,255),1,1,"default-bold","center","center",false,false,false,false,false)
                        if Min < 60 then
                        dxDrawBorderedText("["..Format.."]",WorldPositionX,WorldPositionY-35,WorldPositionX,WorldPositionY,tocolor(200,15,15,255),1,1,"default-bold","center","center",false,false,false,false,false)
                        else
						dxDrawBorderedText("[60:00]+",WorldPositionX,WorldPositionY-35,WorldPositionX,WorldPositionY,tocolor(200,15,15,255),1,1,"default-bold","center","center",false,false,false,false,false)
                        end
                    end
                end
            end           
		end
    end
end
addEventHandler( "onClientRender", root,AFK)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function()
    for i, player in ipairs(getElementsByType("player")) do
        if getElementData(player, "AFK") == false then
            if player ~= localPlayer then
            systemUpTime = nil
            end
		end
	end
end
)

function dxDrawBorderedText(text, left, top, right, bottom, color, scale, outlinesize, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
    local outlinesize = math.min(scale, outlinesize)
    if outlinesize > 0 then
        for offsetX=-outlinesize,outlinesize,outlinesize do
            for offsetY=-outlinesize,outlinesize,outlinesize do
                if not (offsetX == 0 and offsetY == 0) then
                    dxDrawText(text:gsub("#%x%x%x%x%x%x",""), left+offsetX, top+offsetY, right+offsetX, bottom+offsetY, tocolor(0, 0, 0, 200), scale, font, alignX, alignY, clip, wordBreak, postGUI)
                end
            end
        end
    end
    dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
end