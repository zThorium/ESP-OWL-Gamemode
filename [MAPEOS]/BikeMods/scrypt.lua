

-- start


function onResourceStart()
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

--- pojazd




txd = engineLoadTXD ( "caballo.txd",586 )
engineImportTXD ( txd, 586 )  

dff = engineLoadDFF ( "caballo.dff", 586)
engineReplaceModel ( dff, 586 )    

txd = engineLoadTXD ( "yzfr6.txd",521 )
engineImportTXD ( txd, 521 )  

dff = engineLoadDFF ( "yzfr6.dff", 521)
engineReplaceModel ( dff, 521 )   

txd = engineLoadTXD ( "s1000rr.txd",522 )
engineImportTXD ( txd, 522 )  

dff = engineLoadDFF ( "s1000rr.dff", 522)
engineReplaceModel ( dff, 522 )   




