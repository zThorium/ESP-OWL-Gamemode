-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD ( "ByCorleone.txd" ) --Coloque o nome do TXD
engineImportTXD ( txd, 13658 ) --Coloque o ID do objeto que você quer modificar
col = engineLoadCOL ( "ByCorleone.col" ) --Coloque o nome do arquivo COL
engineReplaceCOL ( col, 13658 ) --Coloque o ID do objeto que você quer modificar
dff = engineLoadDFF ( "ByCorleone.dff", 0 ) --Coloque o nome do DFF e não mexa nesse 0
engineReplaceModel ( dff, 13658 ) --Coloque o ID do objeto que você quer modificar
engineSetModelLODDistance(13658, 500) --ID do objeto e a distância que ele irá carregar - distancia está como 500
end)
