addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('object.txd',true)
engineImportTXD(txd, 1918)
local dff = engineLoadDFF('object.dff', 0)
engineReplaceModel(dff, 1918)
local col = engineLoadCOL('object.col')
engineReplaceCOL(col, 1918)
engineSetModelLODDistance(1918, 500)
end)

--- Sitemiz : https://sparrow-mta.blogspot.com/

--- Facebook : https://facebook.com/sparrowgta/
--- İnstagram : https://instagram.com/sparrowmta/
--- YouTube : https://www.youtube.com/@TurkishSparroW/

--- Discord : https://discord.gg/DzgEcvy