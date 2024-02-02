

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD ( "aero.txd" ) 
engineImportTXD ( txd, 2911 ) 
col = engineLoadCOL ( "aero.col" ) 
engineReplaceCOL ( col, 2911 ) 
dff = engineLoadDFF ( "aero.dff", 0 ) 
engineReplaceModel ( dff, 2911 ) 
engineSetModelLODDistance(2911, 500) 
end)