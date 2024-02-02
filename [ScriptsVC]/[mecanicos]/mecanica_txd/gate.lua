local gate = createObject(1939,  2519.1999511719, -1942.1999511719, 12.300000190735, 0, 0, 180) 
local marker = createMarker(2489.1181640625,-1942.5299072266,13.39999961853, "cylinder", 12, 0, 0, 0, 0) 
  
function moveGate(thePlayer) 
          moveObject(gate, 1000, 2519.1999511719, -1942.1999511719, 6.6999998092651) 
     end 
addEventHandler("onMarkerHit", marker, moveGate) 
  
function move_back_gate() 
     moveObject(gate, 1000, 2519.1999511719, -1942.1999511719, 12.300000190735) 
end 
addEventHandler("onMarkerLeave", marker, move_back_gate) 

removeWorldModel(5232,9999,1415.5999755859,-1339.0999755859,14.199999809265) -- REMOVER FIOS ENCIMA DA MODELAGEM