local screenW, screenH = guiGetScreenSize()

local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
    for _, component in ipairs( components ) do
        setPlayerHudComponentVisible( component, false )
    end
end)

addEventHandler("onClientRender", root,
    function()

    local salud = getElementHealth ( localPlayer )
    local armadura = getPedArmor (localPlayer)
    local pMoney = ("%008d"):format(getElementData(localPlayer, "money") or 0 )
    local showammo1 = getPedAmmoInClip (localPlayer,getPedWeaponSlot(localPlayer))
    local showammo2 = getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer)
    local showammo3 = getPedTotalAmmo(getLocalPlayer())
    local arma = getPedWeapon (localPlayer)
    local vidaActual = (screenW * 0.0922) * (salud/100)
    local armaduraActual = (screenW * 0.0922) * (armadura/100)
    local bankmoney = ("%008d"):format(getElementData(localPlayer, "bankmoney") or 0 )

        dxDrawRectangle(1296, 172, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawRectangle(1297, 173, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawRectangle(1291, 166, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawRectangle(screenW * 0.8521, screenH * 0.1979, screenW * 0.0974, screenH * 0.0273, tocolor(0, 0, 0, 255), false)

        dxDrawRectangle(screenW * 0.8565, screenH * 0.2031, vidaActual, screenH * 0.0143, tocolor(139, 0, 0, 255), false)

        dxDrawImage(screenW * 0.7811, screenH * 0.0898, screenW * 0.0681, screenH * 0.1393, ":HudEstiloPM/img/"..arma..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawRectangle(screenW * 0.8521, screenH * 0.1510, armaduraActual, screenH * 0.0273, tocolor(0, 0, 0, 255), false)

        dxDrawRectangle(screenW * 0.8543, screenH * 0.1563, armaduraActual, screenH * 0.0143, tocolor(255, 255, 255, 255), false)

        dxDrawText("$"..pMoney, (screenW * 0.7775) - 1, (screenH * 0.2292) - 1, (screenW * 0.9056) - 1, (screenH * 0.2747) - 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..pMoney, (screenW * 0.7775) + 1, (screenH * 0.2292) - 1, (screenW * 0.9056) + 1, (screenH * 0.2747) - 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..pMoney, (screenW * 0.7775) - 1, (screenH * 0.2292) + 1, (screenW * 0.9056) - 1, (screenH * 0.2747) + 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..pMoney, (screenW * 0.7775) + 1, (screenH * 0.2292) + 1, (screenW * 0.9056) + 1, (screenH * 0.2747) + 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..pMoney, screenW * 0.7775, screenH * 0.2292, screenW * 0.9056, screenH * 0.2747, tocolor(39, 93, 41, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)

        dxDrawText("$"..bankmoney, (screenW * 0.7775) - 1, (screenH * 0.2669) - 1, (screenW * 1.0095) - 1, (screenH * 0.3620) - 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..bankmoney, (screenW * 0.7775) + 1, (screenH * 0.2669) - 1, (screenW * 1.0095) + 1, (screenH * 0.3620) - 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..bankmoney, (screenW * 0.7775) - 1, (screenH * 0.2669) + 1, (screenW * 1.0095) - 1, (screenH * 0.3620) + 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..bankmoney, (screenW * 0.7775) + 1, (screenH * 0.2669) + 1, (screenW * 1.0095) + 1, (screenH * 0.3620) + 1, tocolor(0, 0, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("$"..bankmoney, screenW * 0.7775, screenH * 0.2669, screenW * 1.0095, screenH * 0.3620, tocolor(88, 178, 97, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)

        dxDrawText(tostring (showammo2).." - "..tostring (showammo1), screenW * 0.8097, screenH * 0.2201, screenW * 0.8463, screenH * 0.2370, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "top", false, false, false, false, false)

    end
)