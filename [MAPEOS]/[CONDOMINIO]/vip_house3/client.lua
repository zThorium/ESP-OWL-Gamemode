addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('1.txd',true)
engineImportTXD(txd, 1888)
local dff = engineLoadDFF('1.dff', 0)
engineReplaceModel(dff, 1888)
local col = engineLoadCOL('1.col')
engineReplaceCOL(col, 1888)
engineSetModelLODDistance(1888, 9999)
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy