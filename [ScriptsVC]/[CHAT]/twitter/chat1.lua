
addCommandHandler("twt",
    function(player,cmd,...)
	    local msg = table.concat( {...}, " " )
		local name = getPlayerName(player)
        outputChatBox("#FFFFFF[#00CCFFTwitter#FFFFFF] #FFFFFF[#00CCFF@"..name.."#FFFFFF]: "..msg, root, 255, 255, 255, true )
		
	end
)	

