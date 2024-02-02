

-- start


function onResourceStart()
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

--- pojazd




txd = engineLoadTXD ( "bus.txd",431 )
engineImportTXD ( txd, 431 )  

dff = engineLoadDFF ( "bus.dff", 431)
engineReplaceModel ( dff, 431 )    

txd = engineLoadTXD ( "bus1.txd",437 )
engineImportTXD ( txd, 437 )  

dff = engineLoadDFF ( "bus1.dff", 437)
engineReplaceModel ( dff, 437 )    






