addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('d.txd',true)
engineImportTXD(txd, 1856)
local dff = engineLoadDFF('d1.dff', 0)
engineReplaceModel(dff, 1856)
local col = engineLoadCOL('d1.col')
engineReplaceCOL(col, 1856)
engineSetModelLODDistance(1856, 9999)
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy