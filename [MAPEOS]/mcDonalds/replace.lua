txd = engineLoadTXD("txd.pablin", 1880 )
engineImportTXD(txd, 1880)
dff = engineLoadDFF("dff.pablin", 1880 )
engineReplaceModel(dff, 1880)
col = engineLoadCOL ( "col.pablin" )
engineReplaceCOL ( col, 1880 )
engineSetModelLODDistance(1880, 99999999999999999999999999999999999999)--ID do objeto e a distância que ele irá carregar - distancia está como 500