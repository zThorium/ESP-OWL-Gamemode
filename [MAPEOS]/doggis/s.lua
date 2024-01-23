local file = fileOpen("doggis.dff") --Open the file you want
local data = fileRead(file, fileGetSize(file)) --Get the data in it
fileClose(file) --Don't need it anymore
data = teaEncode(data, "secret") --Encrypt the data with the passkey "secret"


function makeFile()
  if fileExists("protected/doggis.dff") then --Check if it's there already
    fileDelete("protected/doggis.dff") --If so, delete it
  else
    local newFile = fileCreate("protected/doggis.dff") --Create a new one in 'protected' directory (so the names don't collide)
    fileWrite(newFile, data) --Write the encrypted data
    fileClose(newFile)
    triggerClientEvent( getRootElement(), "onFileReady", getRootElement() )
  end
end