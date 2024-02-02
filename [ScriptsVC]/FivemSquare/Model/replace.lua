


addEventHandler('onClientResourceStart',resourceRoot,function () 
	txd = engineLoadTXD('Model/Square.txd') 
	engineImportTXD(txd, 1900)
	
	dff = engineLoadDFF('Model/Square.dff', 1900) 
	engineReplaceModel(dff, 1900)
	
	col = engineLoadCOL('Model/Square.col')
	engineReplaceCOL(col, 1900)
end)

addEventHandler('onClientResourceStart',resourceRoot,function () 
	txd = engineLoadTXD('Model/3095.txd' ) 
	engineImportTXD(txd, 3095)
end)


