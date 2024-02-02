addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('bomberos.txd',true)
engineImportTXD(txd, 1902)
local dff = engineLoadDFF('coll.dff', 0)
engineReplaceModel(dff, 1902)
local col = engineLoadCOL('bomberos.col')
engineReplaceCOL(col, 1902)
engineSetModelLODDistance(1902, 11500)
end)


----- Sitemiz : https://sparrow-mta.blogspot.com/

----- Facebook : https://facebook.com/sparrowgta/
----- İnstagram : https://instagram.com/sparrowmta/
----- YouTube : https://youtube.com/c/SparroWMTA/

----- Discord : https://discord.gg/DzgEcvy