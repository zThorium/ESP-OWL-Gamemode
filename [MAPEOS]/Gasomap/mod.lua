function replaceModel() 
txd_floors = engineLoadTXD ( "santamonicalaw2a.txd", 13648 )
engineImportTXD ( txd_floors, 13648 )
dff_floorsx = engineLoadDFF ( "otogar.dff", 13648 )
engineReplaceModel ( dff_floorsx, 13648 )
col = engineLoadCOL( "otogar.col", 13648  )
engineReplaceCOL( col, 13648 )
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)


