local sql = dbConnect("sqlite", "barrayo.db");
dbExec(sql, "CREATE TABLE IF NOT EXISTS barrayo(nombre,yo)")

function revisaryo(usursh)
    local chikoz = dbPoll(dbQuery(sql, "SELECT * FROM barrayo WHERE nombre = ?", usursh), -1)
    for k, barra in ipairs(chikoz) do
        if barra.yo then
            return true
        else
            return false
        end
    end
end

function comandoYO(p, cmd, ...)
    yo = table.concat({...}, " ")
    if #yo < 75 then 
        if not revisaryo(getPlayerName(p)) == true then
           setElementData( p, "yo", yo )
           dbExec(sql,"INSERT INTO barrayo(nombre,yo) VALUES(?,?)", getPlayerName(p), yo)
        else
           setElementData( p, "yo", yo )
           dbExec(sql,"UPDATE barrayo SET yo=? WHERE nombre=?", yo, getPlayerName(p))
        end
    else
        outputChatBox( "Debes colocar como máximo 65 carácteres para el /yo", p, 255, 0, 0 )
    end
end
addCommandHandler("yo", comandoYO)

addEventHandler( "onPlayerLogin", getRootElement(), function()
    local precoz = dbPoll(dbQuery(sql, "SELECT * FROM barrayo WHERE nombre = ?", getPlayerName(source)), -1)
    for k, barra in ipairs(precoz) do
        if barra.yo then
            setElementData(source,"yo", barra.yo)
        else
            setElementData(source,"yo", " ")
        end
    end
end)