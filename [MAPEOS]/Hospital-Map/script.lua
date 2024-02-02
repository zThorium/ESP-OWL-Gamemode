
--------------------------------------------------------
-----------------------Game Light-----------------------
-------- Discord https://discord.gg/HFwHnGguun ---------
--------------------------------------------------------

addEventHandler('onClientResourceStart',resourceRoot,function () 
    txd = engineLoadTXD ( "Files/hospital.txd" )
    engineImportTXD ( txd, 5708 )
    col = engineLoadCOL ( "Files/hospital.col" )
    engineReplaceCOL ( col, 5708 )
    dff = engineLoadDFF ( "Files/hospital.dff", 0 )
    engineReplaceModel ( dff, 5708 )
    engineSetModelLODDistance(5708, 500)
end)

--------------------------------------------------------
-----------------------Game Light-----------------------
-------- Discord https://discord.gg/HFwHnGguun ---------
--------------------------------------------------------
