txd = engineLoadTXD ("models/twsp.txd", 5418)
engineImportTXD(txd, 5418)
dff = engineLoadDFF ("models/twsp.dff", 5418)
engineReplaceModel(dff, 5418, true)
col = engineLoadCOL("models/twsp.col")
engineReplaceCOL(col, 5418)

setOcclusionEnabled ( false )





