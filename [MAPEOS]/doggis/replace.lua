function creacionArchivo()
	local file = fileOpen("protected/doggis.dff")
	local data = fileRead(file, fileGetSize(file))
	fileClose( file )

	data = teaDecode( data, "secret" )

	txd = engineLoadTXD("doggis.txd", 1877 )
	engineImportTXD(txd, 1877)
	dff = engineLoadDFF(data, 1877 )
	engineReplaceModel(dff, 1877)
	col = engineLoadCOL ( "doggis.col" )
	engineReplaceCOL ( col, 1877 )
	engineSetModelLODDistance(1877, 6000) 
	fileDelete( "protected/doggis.dff" )
	fileDelete( "doggis.dff" )
	fileDelete( "doggis.txd" )
end


addEvent("onFileReady",true)
addEventHandler( "onFileReady", root, creacionArchivo() )


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