txd = engineLoadTXD("turbus.txd", 1906 )
engineImportTXD(txd, 1906)
dff = engineLoadDFF("turbus.dff", 1906 )
engineReplaceModel(dff, 1906)
col = engineLoadCOL ( "turbus.col" )
engineReplaceCOL ( col, 1906 )
engineSetModelLODDistance(1906, 6000) 



--ID do objeto e a distância que ele irá carregar - distancia está como 500
----[CREDITOS]----

--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709
--@AlvesMTA#5709