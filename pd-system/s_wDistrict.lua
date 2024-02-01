addEvent("weaponDistrict:doDistrict", true)

function weaponDistrict_doDistrict(name)
	exports["chat-system"]:districtIC(client, _, "Escucharías una serie de fuertes " .. name .. " disparos resonaron en los alrededores")
end

addEventHandler("weaponDistrict:doDistrict", root, weaponDistrict_doDistrict)