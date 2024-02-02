

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD ( "aero.txd" ) 
engineImportTXD ( txd, 18071 ) 
col = engineLoadCOL ( "aero.col" ) 
engineReplaceCOL ( col, 18071 ) 
dff = engineLoadDFF ( "aero.dff", 0 ) 
engineReplaceModel ( dff, 18071 ) 
engineSetModelLODDistance(18071, 500) 
end)