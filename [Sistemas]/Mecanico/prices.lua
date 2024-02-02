--[[
{"windscreen_dummy", "Parabrisas"},
{"bump_front_dummy", "Parachoques delantero"},
{"bump_rear_dummy", "Parachoques trasero"},
{"bonnet_dummy", "Capó"},
{"boot_dummy", "Csomagtartó"},
{"door_lf_dummy", "Puerta delantera izquierda"},
{"door_rf_dummy", "Puerta delantera derecha"},
{"door_lr_dummy", "Puerta trasera izquierda"},
{"door_rr_dummy", "Puerta trasera derecha"},
{"wheel_rf_dummy", "Rueda delantera derecha"},
{"wheel_lf_dummy", "Rueda delantera izquierda"},
{"wheel_rb_dummy", "Rueda trasera derecha"},
{"wheel_lb_dummy", "Rueda trasera izquierda"},
{"wheel_rear", "Rueda trasera"},
{"wheel_front", "Rueda delantera"}

Para puertas, capot, etc.:
1: Entreabierta, intacta
2: Cerrado, dañado
3: Entreabierta, dañado
4: Desaparecido

Ejemplo
["door_lf_dummy"] = {10, 20, 30, 40},

Ruedas:
1: Plano
2: Caido
3: Sin colisiones: no creo que sea mucho por lograr.

Ejemplo
["wheel_rb_dummy"] = {10, 20, 30},

Parachoques, parabrisas y "front-left panel", "rear-left panel" y el resto, no saben que
1: Lesionado
2: Bastante mal
3: Muy dañado

Ejemplo
["windscreen_dummy"] = {10, 20, 30},


Motor:
1: 999 y 750
2: 749 y 500
3: 499 y 250
4: 249 entre y 0 (menos de 250 creo que el coche ya se está quemando, así que no creo que sea así).
5: Si, debido a un error, no se puede recuperar el estado del motor.

Ejemplo
["Motor"] = {10, 20, 30, 40, 20},
]]
repairSoundPath = "sound.wav"
repairTime = 5--En segundos

--Convertir a milisegundos
repairTime = repairTime * 1000

priceTable = {
	["Motor"] = {10,20,30,40},
	["windscreen_dummy"] = {10, 15, 20},
	["bump_front_dummy"] = {15, 20, 25},
	["bump_rear_dummy"] = {15, 20, 25},
	["bonnet_dummy"] = {15, 20, 25, 30},
	["boot_dummy"] = {15, 20, 25, 30},
	["door_lf_dummy"] = {15, 20, 25, 30},
	["door_rf_dummy"] = {15, 20, 25, 30},
	["door_lr_dummy"] = {15, 20, 25, 30},
	["door_rr_dummy"] = {15, 20, 25, 30},
	
	["wheel_rf_dummy"] = {15, 20, 25, 30},
	["wheel_lf_dummy"] = {15, 20, 25, 30},
	["wheel_rb_dummy"] = {15, 20, 25, 30},
	["wheel_lb_dummy"] = {15, 20, 25, 30},
	
	["wheel_rear"] = {15, 20, 25, 30},
	["wheel_front"] = {15, 20, 25, 30},
}
defPrice = 10 --Si la tabla no incluye el precio, cuánto sería el predeterminado.