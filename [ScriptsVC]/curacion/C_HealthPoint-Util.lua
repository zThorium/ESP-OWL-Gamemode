----------------------------------------
-- Name: Health Point / Ponto de Cura --
-- 			SIDE: Client (Utiç)	      --
--        Autor: #Tasi, MrDante 	  --
----------------------------------------

Positions = { -- Caso queira Colocar mais posições, adicione aqui.
	{ -309.35418701172, 1051.21484375, 20.803682327271 },
	{ 1169.3585205078, -1328.3399658203, 16.443639755249 },
	{ 1607.3000488281, 1823.5, 10.800000190735 },
	{ 2045.6733398438, -1420.1397705078, 17.66993522644 }
}


-- Outra parte de utilidade no resource.

function dxDrawLineRect(startX, startY, endX, endY, color, width, postGUI)
	dxDrawLine ( startX, startY, startX+endX, startY, color, width, postGUI )
	dxDrawLine ( startX, startY, startX, startY+endY, color, width, postGUI )
	dxDrawLine ( startX, startY+endY, startX+endX, startY+endY,  color, width, postGUI )
	dxDrawLine ( startX+endX, startY, startX+endX, startY+endY, color, width, postGUI )
end

function isCursorOnElement(x,y,w,h)
	if (not isCursorShowing()) then
		return false
	end
	local mx,my = getCursorPosition ()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got "..tostring(ped).."]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end
