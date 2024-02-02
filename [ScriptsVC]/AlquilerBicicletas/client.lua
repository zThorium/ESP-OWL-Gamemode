--------------------------------------------[Устройство]
local entradaB = createMarker(2000.3034667969 ,-2275.4794921875 ,14.41695022583, "cylinder", 1, 255, 255, 255, 0)

addEventHandler( "onClientRender", root, function()
       local x, y, z = getElementPosition( entradaB )
       local Mx, My, Mz = getCameraMatrix(   )
        if ( getDistanceBetweenPoints3D( x, y, z, Mx, My, Mz ) <= 15 ) then
           local WorldPositionX, WorldPositionY = getScreenFromWorldPosition( x, y, z +1, 0.07 )
            if ( WorldPositionX and WorldPositionY ) then
			    dxDrawText("Alquiler de Bicicletas", WorldPositionX - 1, WorldPositionY + 1, WorldPositionX - 1, WorldPositionY + 1, tocolor(0, 0, 0, 255), 1.52, "default-bold", "center", "center", false, false, false, false, false)
			    dxDrawText("Alquiler de Bicicletas", WorldPositionX - 1, WorldPositionY + 1, WorldPositionX - 1, WorldPositionY + 1, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
            end
      end
end 
)
---------------------------------------------

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

wndArenda = guiCreateWindow(0,0,500,150,"Alquiler de Bicicletas",false)
centerWindow(wndArenda)
guiSetVisible(wndArenda,false)

label1 = guiCreateLabel(0,30,490,480, "Si no tienes transporte, ¡puedes alquilar una bicicleta!\nCosto 1.500 Pesos $.\nSi dejas caer la bicicleta durante más de 30 segundos, desaparecerá!\nLa función está disponible un número ilimitado de veces!", false, wndArenda)
guiSetFont(label1, "default-bold-small")
guiLabelSetHorizontalAlign(label1, "center", false)

local btn1 = guiCreateButton(20,100,200,35,"Alquilar",false,wndArenda)
local btn2 = guiCreateButton(280,100,200,35,"Cancelar",false,wndArenda)

addEventHandler('onClientGUIClick',wndArenda,function()
    if source == btn1 then
        triggerServerEvent("onPlayerUseCustomPickup", localPlayer)
        guiSetVisible(wndArenda,false)
        showCursor(false)
    elseif source == btn2 then
        guiSetVisible(wndArenda,false)
        showCursor(false)
    end
end)

function changeArendaMenuState()
    guiSetVisible(wndArenda,true)
    showCursor(true)
end
addEvent("changeArendaMenuState", true)
addEventHandler("changeArendaMenuState", getRootElement(), changeArendaMenuState)