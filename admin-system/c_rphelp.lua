myWindow = nil
pressed = false

function bindKeys()
	bindKey("F1", "down", F1RPhelp)
end
addEventHandler("onClientResourceStart", getRootElement(), bindKeys)

function resetState()
	pressed = false
end

function F1RPhelp( key, keyState )
	if not (pressed) then
		pressed = true
		setTimer(resetState, 200, 1)
		if ( myWindow == nil ) then		
			local xmlExplained = xmlLoadFile( "whatisroleplaying.xml" )
			local xmlOverview = xmlLoadFile( "overview.xml" )
			
			myWindow = guiCreateWindow ( 0.3, 0.3, 0.7, 0.7, "ChileStreet - F1 Ayuda", true )
			guiWindowSetSizable(myWindow, false)
			local tabPanel = guiCreateTabPanel ( 0, 0.1, 1, 1, true, myWindow )
			
			local tabRules = guiCreateTab( "Rules", tabPanel )
			local memoRules = guiCreateMemo ( 0, 0.1, 1, 1, getElementData(getResourceRootElement(getResourceFromName("account-system")), "rules:text") or "Error al recuperar reglas!", true, tabRules )
			guiMemoSetReadOnly(memoRules, true)
			
			local tabExplained = guiCreateTab( "Roleplay Explicado", tabPanel )
			local memoExplained = guiCreateMemo ( 0, 0.1, 1, 1, xmlNodeGetValue( xmlExplained ), true, tabExplained )
			guiMemoSetReadOnly(memoExplained, true)
			
			local tabOverview = guiCreateTab( "Roleplay Descripción general", tabPanel )
			local memoOverview = guiCreateMemo ( 0, 0.1, 1, 1, xmlNodeGetValue( xmlOverview ), true, tabOverview )
			guiMemoSetReadOnly(memoOverview, true)
			
			showCursor( true )
		else
			destroyElement(myWindow)
			myWindow = nil
			showCursor(false)
		end
	end
end