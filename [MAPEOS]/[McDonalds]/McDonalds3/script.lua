

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD ( "aero.txd" ) 
engineImportTXD ( txd, 5418 ) 
col = engineLoadCOL ( "aero.col" ) 
engineReplaceCOL ( col, 5418 ) 
dff = engineLoadDFF ( "aero.dff", 0 ) 
engineReplaceModel ( dff, 5418 ) 
engineSetModelLODDistance(5418, 500) 
end)
