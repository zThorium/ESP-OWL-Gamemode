local currentStage = 1
local FINAL_STAGE = 13
local TUTORIAL_STAGES = {
    [1] = {"Bienvenido", "¡Hola y bienvenido a ChileStreet! \n\nHas superado con éxito la etapa de solicitud y estás en el camino para comenzar a jugar roles aquí. Para ayudarte a comenzar, hemos creado este tutorial, ¡disfrútalo!" , 1271.6337890625, -2037.69140625, 81.409843444824, 1125.6396484375, -2036.96484375, 69.880661010742},
    [2] = {"Propiedades", "Los Santos ofrece una variedad de propiedades que puede comprar, incluidas ubicaciones comerciales y residenciales, como tiendas, garajes, negocios y casas. Los nuevos personajes reciben una ficha de propiedad que te permite comprar una casa con un valor de hasta $40 000, ¡lo que te permite comenzar a jugar roles inmediatamente como si ya fueras residente de Los Santos!\n\nAl comprar una propiedad, puedes optar por usar una ficha de propiedad predeterminada. interior proporcionado o puede cargar su propio interior mapeado personalizado, que se puede comprar con GameCoins a través de nuestro cargador de interiores en el Panel de control de usuario.", 2092.314453125, -1220.6669921875, 35.311351776123, 2108.9404296875, -1240.2802734375, 27.0014 24789429},
    [3] = {"Vehículos", "Hay una gran variedad de vehículos siempre disponibles en las tiendas con guión (sin incluir los vehículos vendidos por jugadores): \n\n - Tienda de autos Ocean Docks (automóviles estándar) \n - Tienda de camiones/industrial Ocean Docks (autos industriales) Vehículos) \n - Jefferson Car Shop (automóviles estándar) \n - Santa Maria Beach Boat Shop (barcos) \n - Grotti's Car Shop (vehículos deportivos) \n - Idlewood Bike Shop (motocicletas) \n\nSe proporcionan nuevos personajes con un token de vehículo, al igual que los tokens de propiedad, estos tokens le permiten comprar un vehículo de inmediato sin tener que trabajar en un guión. Tienen un valor de hasta $35 000. ¡No olvide /estacionar su nuevo vehículo! ocurre la reaparición y no lo estacionas, se eliminará.", 2111.3681640625, -2116.8876953125, 21.02206993103, 2128.1513671875, -2138.896484375, 15.001725196838},
    [4] = {"DMV", "Aquí en el Departamento de Vehículos Motorizados (también conocido como DMV) puedes hacer muchas cosas. La razón principal por la que visitarías aquí es para adquirir una licencia de conducir, pero siempre puedes adquirir muchos tipos diferentes de licencias aquí e incluso registrarte. / cancelar el registro de sus vehículos. \n\nDesde el DMV también puede comprar documentos de transacción del DMV, estos le permiten vender su vehículo a otro jugador dentro del estacionamiento del DMV. (No puede vender su vehículo simbólico).", 1061.421875, -1752.6943359375 , 25.57329750061, 1105.625, -1792.9228515625, 17.421173095703},
    [5] = {"Banco", "Aquí está el Banco de Los Santos. En el banco puedes retirar, depositar y transferir dinero entre otros jugadores y facciones. El banco también es el lugar donde puedes solicitar tarjetas de cajero automático.", 626.2001953125, - 1207.552734375, 35.195793151855, 600.30859375, -1239.025390625, 20.625173568726},
    [6] = {"Cajero Automatico", "Alrededor de Los Santos, verás muchos cajeros automáticos.\n\nEstos se pueden utilizar arrastrando la tarjeta que solicitaste en el banco hasta la máquina. Dependiendo de la tarjeta que hayas comprado en el Banco podrás retirar una cierta cantidad de un cajero automático.\n\nOfrecemos tres tipos de tarjetas de cajero automático, estas son: \n - Tarjeta de cajero automático básica ($0 -> $10,000) \ n - Tarjeta de cajero automático premium ($0 -> $50 000) \n - Tarjeta de cajero automático Ultimate (ilimitada)\n\nCada tarjeta de cajero automático tiene su propio costo, puede ver los costos en el NPC del banco.", 1106.2578125, -1792.5869140625, 19.298328399658, 1110.90625, -1790.431640625, 16.59375},
    [7] = {"Ayuntamiento", "Aquí en County Hall, hay una variedad de trabajos entre los que puede elegir, estos trabajos están diseñados para ayudarlo a recuperarse financieramente. Incluyen:\n- Mantenimiento de la ciudad\n- Conducción de autobuses\n- Conducción de taxis\n- Conductor de reparto\n\nOtro trabajo inicial al que no puedes inscribirte en el Ayuntamiento es la pesca. Para comenzar a pescar, debes comprar una caña de pescar en una tienda general, un bote en la tienda de botes y luego salir al mar. Los jugadores que busquen el trabajo de mecánico deben presentarse ante un administrador para que se lo configure y deben tener un motivo de RP para adquirir ese trabajo.", 1526.1279296875, -1712.4970703125, 25.736494064331, 1497.982421875, -1738.583984375, 18.620281219482},
    [8] = {"Taxi y Micrero", "Aquí está la estación de Taxis y Autobuses. \n\nPodrás encontrar taxis y autobuses listos para tomar (¡necesitas el trabajo antes de poder conducir los vehículos y transportar a los ciudadanos de Los Santos!). Tenga en cuenta que estos vehículos deben utilizarse para fines laborales y no para transporte personal.", 1823.2099609375, -1912.7138671875, 30.250659942627, 1789.2900390625, -1910.4990234375, 19.221006393433},
    [9] = {"RSHaul", "Aquí está RSHaul \n\nEn RSHaul hay 5 niveles de progresión, comenzando con las camionetas pequeñas y avanzando hasta los grandes camiones de transporte comercial. Como conductor de RSHaul, tienes la tarea de realizar entregas en los lugares decididos por la empresa de transporte, dependiendo de cada trabajo se te pagará una determinada cantidad. Estas entregas se realizan tanto en ubicaciones preestablecidas como en tiendas de jugadores, por lo que su entrega ayuda a abastecer las tiendas y marcar una diferencia en la economía del servidor.", -104.125, -1119.65234375, 2.7560873031616, -79.01953125, -1117.978515625, 1.078125},
    [10] = {"Pescar", "¿Quieres ser el próximo Ray Scott? \n\nPara pescar, todo lo que necesitas es una caña y un bote, ¡y luego dirígete a la bahía! Puedes comenzar a pescar una vez que tengas los artículos con /startfishing. Después de unos momentos, verás que has pescado un pez. Después de pescar, se te entregará el artículo de pescado que luego podrás vender al pescador John, que se encuentra junto a la tienda de cebos en Los Santos, en los muelles.", 163.1201171875, -1903.20703125, 19.174238204956, 134.77734375, -1962.0517578125, 15.005571365356},
    [11] = {"Facciones Legales", "Después de ganar un poco de dinero inicial con uno de nuestros muchos trabajos programados, es posible que desees comenzar a considerar la posibilidad de unirte a una facción legal.\n\nNormalmente puedes encontrar reclutamiento para facciones legales en los foros de Discord o en el sitio web de las facciones (los enlaces a sitios web gubernamentales pueden se puede encontrar en owlgaming.net y la mayoría de los sitios web de facciones se pueden encontrar en discord.", 1513.9677734375, -1674.328125, 33.480712890625, 1552.08203125, -1675.1279296875, 17.445131301882},
    [12] = {"Facciones Ilegales", "¿Te apetece ganar un poco de dinero pero no quieres hacerlo por medios legales?\n\nEn ese caso, es posible que te interese unirte a una facción ilegal. Las facciones ilegales son responsables de abastecer de contrabando las calles. Cada facción suministra diferentes tipos de contrabando. Algunas facciones ilegales juegan roles en las calles y otras facciones juegan roles detrás de escena, dependiendo de cómo desarrolles tu personaje, puedes elegir a qué tipo de facción ilegal puedes unirte. Puedes ver facciones ilegales en los foros de Discord.", 2180.5078125, -1647.9208984375, 29.288076400757, 2140.115234375, -1625.4150390625, 15.865843772888},
    [13] = {"Nota Final", "Los juegos de rol con facciones son tan infinitos como tu imaginación, explorando el servidor y conociendo gente nueva. Encontrarás muchos escenarios interesantes tanto legales como ilegales.", 1981.0166015625, -1349.6162109375, 61.649375915527, 1925.7919921875, -1400.3291015625, 34.439781188965}
}

function runTutorial()
    tutorialWindow = guiCreateWindow(0.78, 0.63, 0.21, 0.35, "", true)
    guiWindowSetMovable(tutorialWindow, false)
    guiWindowSetSizable(tutorialWindow, false)
    showCursor(true)
    fadeCamera(true, 2.5)

    tutorialLabel = guiCreateLabel(0.02, 0.08, 0.95, 0.77, "", true, tutorialWindow)
    guiSetFont(tutorialLabel, "clear-normal")
    guiLabelSetHorizontalAlign(tutorialLabel, "left", true)

    backButton = guiCreateButton(0.02, 0.87, 0.45, 0.10, "Anterior", true, tutorialWindow)
    nextButton = guiCreateButton(0.52, 0.87, 0.45, 0.10, "Siguiente", true, tutorialWindow)

    setStage(1)
    addEventHandler("onClientGUIClick", tutorialWindow, buttonFunctionality)
end
addEvent("tutorial:run", true)
addEventHandler("tutorial:run", root, runTutorial)

function setStage(stage)
    if (stage > FINAL_STAGE) then 
        currentStage = -1
        fadeCamera(false)
        guiSetText(tutorialWindow, "Chile Street - Tutorial Finalizado")
        guiSetText(tutorialLabel, "Has completado el tutorial, ¿qué te gustaría hacer a continuación?")
        guiSetText(nextButton, "Finalizar tutorial")
    else
        guiSetText(tutorialWindow, "Chile Street Tutorial - " .. TUTORIAL_STAGES[stage][1])
        guiSetText(tutorialLabel, TUTORIAL_STAGES[stage][2])
        setCameraMatrix(TUTORIAL_STAGES[stage][3], TUTORIAL_STAGES[stage][4], TUTORIAL_STAGES[stage][5], TUTORIAL_STAGES[stage][6], TUTORIAL_STAGES[stage][7], TUTORIAL_STAGES[stage][8], 0, 90)
        
        if not guiGetVisible(tutorialWindow) then 
            guiSetVisible(tutorialWindow, true)
        end
    end
end

function buttonFunctionality(button, state)
    if (button == "left") and (source == backButton) then 
        if (currentStage == 1) then 
            return
        elseif (currentStage == -1) then 
            currentStage = FINAL_STAGE
            fadeClientScreen()
            guiSetText(nextButton, "Siguiente")
            setTimer(setStage, 1000, 1, currentStage)
        else
            currentStage = currentStage - 1
            fadeClientScreen()
            setTimer(setStage, 1000, 1, currentStage)
        end            
    elseif (button == "left") and (source == nextButton) then 
        if (currentStage == -1) then 
            removeEventHandler("onClientGUIClick", tutorialWindow, buttonFunctionality)
            destroyElement(tutorialWindow)   
            triggerServerEvent("accounts:tutorialFinished", resourceRoot)
        else
            currentStage = currentStage + 1
            fadeClientScreen()
            setTimer(setStage, 1000, 1, currentStage)
        end
    end
end

function fadeClientScreen()
    fadeCamera(false)
    setTimer(function()
        fadeCamera(true, 2.5)
    end, 1000, 1)
end
