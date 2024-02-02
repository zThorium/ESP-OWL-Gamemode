--[[
 * ***********************************************************************************************************************
 * Copyright (c) 2015 OwlGaming Community - All Rights Reserved
 * All rights reserved. This program and the accompanying materials are private property belongs to OwlGaming Community
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * ***********************************************************************************************************************
 ]]

--- clothe shop skins
blackMales = {293, 300, 284, 278, 274, 265, 19, 310, 311, 301, 302, 296, 297, 269, 270, 271, 7, 14, 15, 16, 17, 18, 20, 21, 22, 24, 25, 28, 35, 36, 51, 66, 67, 79,
80, 83, 84, 102, 103, 104, 105, 106, 107, 134, 136, 142, 143, 144, 156, 163, 166, 168, 176, 180, 182, 183, 185, 220, 221, 222, 249, 253, 260, 262 }
whiteMales = {126, 268, 288, 287, 286, 285, 283, 282, 281, 280, 279, 277, 276, 275, 267, 266, 239, 167, 71, 305, 306, 307, 308, 309, 312, 303, 299, 291, 292, 294, 295, 1, 2, 23, 26,
27, 29, 30, 32, 33, 34, 35, 36, 37, 38, 43, 44, 45, 46, 47, 48, 50, 51, 52, 53, 58, 59, 60, 61, 62, 68, 70, 72, 73, 78, 81, 82, 94, 95, 96, 97, 98, 99, 100, 101, 108, 109, 110,
111, 112, 113, 114, 115, 116, 120, 121, 124, 125, 127, 128, 132, 133, 135, 137, 146, 147, 153, 154, 155, 158, 159, 160, 161, 162, 164, 165, 170, 171, 173, 174, 175, 177,
179, 181, 184, 186, 187, 188, 189, 200, 202, 204, 206, 209, 212, 213, 217, 223, 230, 234, 235, 236, 240, 241, 242, 247, 248, 250, 252, 254, 255, 258, 259, 261, 264, 272 }
asianMales = {290, 49, 57, 58, 59, 60, 117, 118, 120, 121, 122, 123, 170, 186, 187, 203, 210, 227, 228, 229, 294}
blackFemales = {--[[245, ]]9, 304, 298, 10, 11, 12, 13, 40, 41, 63, 64, 69, 76, 139, 148, 190, 195, 207, 215, 218, 219, 238, 243, 244, 256, 304 } -- 245 = Santa, so disabled.
whiteFemales = {91, 191, 12, 31, 38, 39, 40, 41, 53, 54, 55, 56, 64, 75, 77, 85, 87, 88, 89, 90, 92, 93, 129, 130, 131, 138, 140, 145, 150, 151, 152, 157, 172, 178, 192, 193, 194,
196, 197, 198, 199, 201, 205, 211, 214, 216, 224, 225, 226, 231, 232, 233, 237, 243, 246, 251, 257, 263, 298 }
asianFemales = {38, 53, 54, 55, 56, 88, 141, 169, 178, 224, 225, 226, 263}
local fittingskins = {[0] = {[0] = blackMales, [1] = whiteMales, [2] = asianMales}, [1] = {[0] = blackFemales, [1] = whiteFemales, [2] = asianFemales}}
-- Removed 9 as a black female
-- these are all the skins
disabledUpgrades = {
	[1142] = true,
	[1109] = true,
	[1008] = true,
	[1009] = true,
	[1010] = true,
	[1158] = true,
}

local restricted_skins = {
	[71] = true,
	[265] = true,
	[266] = true,
	[267] = true,
	[274] = true,
	[275] = true,
	[276] = true,
	[277] = true,
	[278] = true,
	[279] = true,
	[275] = true,
	[280] = true,
	[281] = true,
	[282] = true,
	[283] = true,
	[284] = true,
	[285] = true,
	[286] = true,
	[287] = true,
	[288] = true,
	[300] = true,
 }
 
bandanas = { [122] = true, [123] = true, [124] = true, [136] = true, [168] = true, [125] = true, [158] = true, [135] = true, [237] = true, [238] = true, [239] = true }

function getRestrictedSkins()
	return restricted_skins
end

function getDisabledUpgrades()
	return disabledUpgrades
end
skins = { 1, 2, 268, 269, 270, 271, 272, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 66, 67, 68, 69, 72, 73, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 178, 179, 180, 181, 182, 183, 184, 185, 186, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 263, 264 }
local wheelPrice = 2500
local priceReduce = 1

-- g_shops[1][1][1]['name'] == "Flowers"

g_shops = {
	{ -- 1
		name = "Tienda General",
		description = "Esta tienda vende todo tipo de cosas...como los chinos.",
		image = "general.png",

		{
			name = "Objetos Generales",
			--{ name = "Lottery Ticket", description = "A ticket that can make you or break you.", price = 75, itemID = 68, itemValue = nil, minimum_age = 18 },
			{ name = "Flores", description = "Un ramo de hermosas flores.", price = 4500, itemID = 115, itemValue = 14 },
			{ name = "Directorio telefónico", description = "Un gran directorio telefónico con los números de todos.", price = 23000, itemID = 7 },
			{ name = "Dado", description = "Un dado blanco de seis caras con puntos negros, perfecto para apostar.", price = 1500, itemID = 10, itemValue = 1 },
			{ name = "Dado de 20 caras", description = "Un dado blanco de veinte caras con puntos negros, para esa sensación de Dungeons & Dragons.", price = 2900, itemID = 10, itemValue = 20 },
			{ name = "Palo de golf", description = "Un palo de golf perfecto para hacer un hoyo en uno.", price = 50000, itemID = 115, itemValue = 2 },
			{ name = "Bate de béisbol", description = "Con este puedes hacer un jonrón.", price = 60000, itemID = 115, itemValue = 5 },
			{ name = "Pala", description = "Herramienta perfecta para cavar un hoyo.", price = 40000, itemID = 115, itemValue = 6 },
			{ name = "Taco de billar", description = "Para ese juego de billar de pub.", price = 45000, itemID = 115, itemValue = 7 },
			{ name = "Bastón", description = "Un palo nunca ha sido tan elegante.", price = 40000, itemID = 115, itemValue = 15 },
			{ name = "Extintor de incendios", description = "Nunca hay uno de estos cuando hay un incendio.", price = 50000, itemID = 115, itemValue = 42 },
			{ name = "Lata de spray", description = "¡Ey, mejor no marques con esto, punk!", price = 50000, itemID = 115, itemValue = 41 },
			{ name = "Paracaídas", description = "Si no quieres estrellarte contra el suelo, más vale que compres uno.", price = 370000, itemID = 115, itemValue = 46 },
			{ name = "Guía de la ciudad", description = "Un pequeño folleto de guía de la ciudad.", price = 12000, itemID = 18 },
			{ name = "Mochila", description = "Una mochila de tamaño razonable.", price = 30000, itemID = 48 },
			{ name = "Caña de pescar", description = "Una caña de pescar de acero al carbono de 7 pies.", price = 300000, itemID = 49 },
			{ name = "Máscara", description = "Una máscara de esquí.", price = 20000, itemID = 56 },
			{ name = "Bidón de combustible", description = "Un pequeño bidón de metal para combustible.", price = 35000, itemID = 57, itemValue = 0 },
			{ name = "Botiquín de primeros auxilios", description = "Un pequeño botiquín de primeros auxilios.", price = 15000, itemID = 70, itemValue = 3 },
			{ name = "Papel para liar", description = "Papeles para liar tus cigarrillos.", price = 10000, itemID = 181, itemValue = 20 },

			--[[
			{ name = "Mini Notebook", description = "An empty Notebook, enough to write 5 notes.", price = 10, itemID = 71, itemValue = 5 },
			{ name = "Notebook", description = "An empty Notebook, enough to write 50 notes.", price = 15, itemID = 71, itemValue = 50 },
			{ name = "XXL Notebook", description = "An empty Notebook, enough to write 125 notes.", price = 20, itemID = 71, itemValue = 125 },
			]]
			{ name = "Casco", description = "Un casco comúnmente utilizado por personas que conducen bicicletas.", price = 100000, itemID = 90 },
			{ name = "Casco de motociclista", description = "Un casco comúnmente utilizado por personas que conducen bicicletas.", price = 100000, itemID = 171},
			{ name = "Casco integral", description = "Un casco comúnmente utilizado por personas que conducen bicicletas.", price = 100000, itemID = 172},
			{ name = "Paquete de cigarrillos", description = "Cosas que puedes fumar...", price = 4500, itemID = 105, itemValue = 20, minimum_age = 18 },
			{ name = "Encendedores", description = "Para encender tu adicción, ¡un auténtico Zippo!", price = 45000, itemID = 107 },
			{ name = "Cuchillo", description = "Para ayudarte en la cocina.", price = 100000, itemID = 115, itemValue = 4 },
			{ name = "Baraja de cartas", description = "¿Quieres jugar a un juego?", price = 10000, itemID = 77 },
			{ name = "Marco de fotos", description = "Puedes usar estos para decorar tu interior.", price = 350000, itemID = 147, itemValue = 1 },
			{ name = "Portafolios", description = "Un portafolios de cuero marrón.", price = 75000, itemID = 160},
			{ name = "Bolsa de lona", description = "Una gran bolsa cilíndrica hecha de tela con un cierre de cordón en la parte superior.", price = 60000, itemID = 163},
			{ name = "Libro en blanco", description = "Un libro de tapa dura sin nada escrito en él.", price = 40000, itemID = 178, itemValue = "Nuevo Libro"},
			{ name = "Candado para bicicleta", description = "Un candado de metal que te permite bloquear tu bicicleta", price = 250000, itemID = 275, itemValue = 1},

		},
		{
			name = "Consumible",
			{ name = "Sandwich", description = "Un rico sándwich con queso.", price = 2500, itemID = 8 },
			{ name = "Baltica 0 Alcohol", description = "Una lata de baltica sin alcohol.", price = 3000, itemID = 9 },
		},
	},
	{ -- 2
		name = "Tienda de armas y municiones",
		description = "Todo lo que tu arma necesita desde 1914.",
		image = "gun.png",

		{
			name = "Armas y municiones",
			{ name = "Pistola Colt-45", description = "Una Colt-45 plateada.", price = 850000, itemID = 115, itemValue = 22, license = true },
			{ name = "Pistola Desert Eagle", description = "Una Desert Eagle reluciente.", price = 1200000, itemID = 115, itemValue = 24, license = true },
			{ name = "Escopeta", description = "Una escopeta plateada.", price = 1490000, itemID = 115, itemValue = 25, license = true },
			{ name = "Rifle de caza", description = "Un rifle de caza.", price = 2000000, itemID = 115, itemValue = 33, license = true },
			{ name = "Paquete de munición 9mm", description = "Cartucho: 9mm, compatible con Colt 45, Silenciada, Uzi, MP5, Tec-9. Estilo de bala: Punta flexible expandible (FTX), Peso de la bala: 7.45 gramos, Aplicación: Autodefensa.", price = 70000, itemID = 116, itemValue = 1, ammo = 25, license = true },
			{ name = "Paquete de munición .45 ACP", description = "Cartucho: .45 ACP, compatible con Deagle. Estilo de bala: Chaqueta completa (FMJ), Estuche metálico (MC), Peso de la bala: 11.99 gramos, Aplicación: Blanco, Competición, Entrenamiento.", price = 80000, itemID = 116, itemValue = 4, ammo = 20, license = true },
			{ name = "Paquete de munición calibre 12", description = "Cartucho: Calibre 12, compatible con escopeta, recortada, escopeta de combate. Estilo de bala: Estilo de fábrica, Peso de la bala: 31.89 gramos, Aplicación: Blanco, Caza.", price = 80000, itemID = 116, itemValue = 5, ammo = 20, license = true },
			{ name = "Paquete de munición 7.62mm", description = "Cartucho: 7.62mm, compatible con AK-47, Rifle, Francotirador, Minigun. Estilo de bala: Chaqueta completa (FMJ), Peso de la bala: 9.66 gramos, Aplicación: Práctica, Blanco, Entrenamiento.", price = 130000, itemID = 116, itemValue = 2, ammo = 30, license = true },
			{ name = "Paquete de munición 5.56mm", description = "Cartucho: 5.56mm, compatible con M4. Estilo de bala: Chaqueta completa (FMJ), Peso de la bala: 4.02 gramos, Aplicación: Aplicación de la ley, Plinking.", price = 130000, itemID = 116, itemValue = 3, ammo = 30, license = true },
		}
	},
	{ -- 3
		name = "Tienda de Comida",
		description = "Los alimentos y bebidas menos envenenados del planeta.",
		image = "food.png",

		{
			name = "Comida",
			{ name = "Sándwich", description = "Un delicioso sándwich con queso", price = 4500, itemID = 8 },
			{ name = "Taco", description = "Un taco mexicano grasoso", price = 6000, itemID = 11 },
			{ name = "Hamburguesa", description = "Una hamburguesa doble con queso y tocino", price = 3500, itemID = 12 },
			{ name = "Donut", description = "Un donut caliente cubierto de azúcar pegajosa", price = 1500, itemID = 13 },
			{ name = "Galleta", description = "Una lujosa galleta de chocolate con chispas", price = 1300, itemID = 14 },
			{ name = "Hotdog", description = "¡Un sabroso hotdog!", price = 3800, itemID = 1 },
			{ name = "Panqueque", description = "¡Delicioso, un panqueque!", price = 1400, itemID = 108 },

		},
		{
			name = "Bebestibles",
			{ name = "Refresco", description = "Una lata fría de Sprunk.", price = 4300, itemID = 9 },
			{ name = "Agua", description = "Una botella de agua mineral.", price = 2400, itemID = 15 },

		}
	},
	{ -- 4
		name = "Sex Shop Doña Maria",
		description = "Todos los artículos que necesitarás para pasar una noche perfecta en casa.",
		image = "sex.png",

		{
			name = "Sexy",
			{ name = "Dildo Largo Morado", description = "Un dildo morado muy grande", price = 14000, itemID = 115, itemValue = 10 },
			{ name = "Dildo Corto Beige", description = "Un pequeño dildo beige.", price = 14000, itemID = 115, itemValue = 11 },
			{ name = "Vibrador", description = "Un vibrador, ¿qué más se necesita decir?", price = 25000, itemID = 115, itemValue = 12 },
			{ name = "Flores", description = "Un ramo de hermosas flores.", price = 5000, itemID = 115, itemValue = 14 },
			{ name = "Esposas", description = "Un par de esposas de metal.", price = 90000, itemID = 45 },
			{ name = "Cuerda", description = "Una cuerda larga.", price = 15000, itemID = 46 },
			{ name = "Antifaz", description = "Un antifaz negro.", price = 15000, itemID = 66 },

		},
		{
			name = "Ropas",
			{ name = "Ropa 87", description = "Ropa sexy para personas sexys.", price = 55000, itemID = 16, itemValue = 87 },
			{ name = "Ropa 178", description = "Ropa sexy para personas sexys.", price = 55000, itemID = 16, itemValue = 178 },
			{ name = "Ropa 244", description = "Ropa sexy para personas sexys.", price = 55000, itemID = 16, itemValue = 244 },
			{ name = "Ropa 246", description = "Ropa sexy para personas sexys.", price = 55000, itemID = 16, itemValue = 246 },
			{ name = "Ropa 257", description = "Ropa sexy para personas sexys.", price = 55000, itemID = 16, itemValue = 257 },

		}
	},
	{ -- 5
		name = "Clothes Shop",
		description = "You don't look fat in those!",
		image = "clothes.png",
		-- Items to be generated elsewhere.
		{
			name = "Clothes fitting you"
		},
		{
			name = "Others"
		},
	},
	{ -- 6
		name = "Gym",
		description = "El mejor lugar para aprender sobre el combate cuerpo a cuerpo..",
		image = "general.png",

		{
			name = "Estilos de lucha",
			{ name = "Combate Estándar para Principiantes", description = "Combate estándar para el día a día.", price = 10000, itemID = 20 },
			{ name = "Boxeo para Principiantes", description = "Mike Tyson, drogado.", price = 50000, itemID = 21 },
			{ name = "Kung Fu para Principiantes", description = "Yo sé kung-fu, ¡tú también puedes!", price = 50000, itemID = 22 },
			-- El ID del ítem 23 es solo un libro en griego, de todos modos :o
			{ name = "Agarrar y Patear para Principiantes", description = "¡Patea su cabeza!", price = 50000, itemID = 24 },
			{ name = "Codos para Principiantes", description = "Puede que parezcas tonto, ¡pero le patearás el trasero!", price = 50000, itemID = 25 },

		}
	},
	{ -- 7
		name = "Rapid Auto Parts - Viozy",
		description = "Si no es Viozy, es fraude. Todas las ventas publicadas se reducen en un 50% para miembros exclusivos.",
		image = "viozy-auto.png",
		{
			name = "Aplicación de tinte",
			{ name = "Película de Ventana HP Charcoal", description = "Películas para ventanas Viozy ((50% de probabilidad))", price = 305000 / priceReduce, itemID = 184, itemValue = "Película de Ventana HP Charcoal de Viozy ((50% de probabilidad))" },
			{ name = "Película de Ventana CXP70", description = "Películas para ventanas Viozy CXP70 ((95% de probabilidad))", price = 490000 / priceReduce, itemID = 185, itemValue = "Película de Ventana CXP70 de Viozy ((95% de probabilidad))" },
			{ name = "Cortador de Bordes con Borde Rojo Anodizado", description = "Cortador de bordes para tintado", price = 180000 / priceReduce, itemID = 186, itemValue = "Cortador de Bordes con Borde Rojo Anodizado de Viozy" },
			{ name = "Medidor de Transmisión Espectral Solar", description = "Medidor espectral para probar películas antes de usar", price = 1000000 / priceReduce, itemID = 187, itemValue = "Medidor de Transmisión Espectral Solar de Viozy" },
			{ name = "Tint Chek 2800", description = "Mide la transmisión de luz visible en cualquier película/vidrio", price = 280000 / priceReduce, itemID = 188, itemValue = "Tint Chek 2800 de Viozy" },
			{ name = "Pistola de Calor Equalizer Heatwave", description = "Pistola de calor fácil de usar perfecta para encoger ventanas traseras", price = 530000 / priceReduce, itemID = 189, itemValue = "Pistola de Calor Equalizer Heatwave de Viozy" },
			{ name = "Cubo Cortador Multipropósito de 36 Pulgadas", description = "Ideal para trabajos de corte ligero al aplicar tintado", price = 120000 / priceReduce, itemID = 190, itemValue = "Cubo Cortador Multipropósito de 36 Pulgadas de Viozy" },
			{ name = "Lámpara de Demostración de Tinte", description = "Presentación efectiva de la aplicación de tinte", price = 150000 / priceReduce, itemID = 191, itemValue = "Lámpara de Demostración de Tinte de Viozy" },
			{ name = "Raspador Angular Triumph", description = "Raspador angular de 6 pulgadas para aplicar tintado", price = 100000 / priceReduce, itemID = 192, itemValue = "Raspador Angular Triumph de Viozy" },
			{ name = "Rociador Manual Performax de 48 oz", description = "Rociador manual Performax para aplicación de tintado", price = 200000 / priceReduce, itemID = 193, itemValue = "Rociador Manual Performax de 48 oz de Viozy" },
			{ name = "Botella de Amoníaco", description = "Una botella de solución de amoníaco", price = 50000 / priceReduce, itemID = 260, itemValue = "Botella de Amoníaco" },
		},

		{
			name = "Mecánico",
			{ name = "Encendido de Vehículo - 2010 ((20% de probabilidad))", description = "Encendido de vehículo fabricado por Viozy para 2010", price = 196000 / priceReduce, itemID = 194, itemValue = "Encendido de Vehículo Viozy - 2010 ((20% de probabilidad))" },
			{ name = "Encendido de Vehículo - 2011 ((30% de probabilidad))", description = "Encendido de vehículo fabricado por Viozy para 2011", price = 254000 / priceReduce, itemID = 195, itemValue = "Encendido de Vehículo Viozy - 2011 ((30% de probabilidad))" },
			{ name = "Encendido de Vehículo - 2012 ((40% de probabilidad))", description = "Encendido de vehículo fabricado por Viozy para 2012", price = 364000 / priceReduce, itemID = 196, itemValue = "Encendido de Vehículo Viozy - 2012 ((40% de probabilidad))" },
			{ name = "Encendido de Vehículo - 2013 ((50% de probabilidad))", description = "Encendido de vehículo fabricado por Viozy para 2013", price = 546000 / priceReduce, itemID = 197, itemValue = "Encendido de Vehículo Viozy - 2013 ((50% de probabilidad))" },
			{ name = "Encendido de Vehículo - 2014 ((70% de probabilidad))", description = "Encendido de vehículo fabricado por Viozy para 2014", price = 929000 / priceReduce, itemID = 198, itemValue = "Encendido de Vehículo Viozy - 2014 ((70% de probabilidad))" },
			{ name = "Encendido de Vehículo - 2015 ((90% de probabilidad))", description = "Encendido de vehículo fabricado por Viozy para 2015", price = 1765000 / priceReduce, itemID = 199, itemValue = "Encendido de Vehículo Viozy - 2015 ((90% de probabilidad))" },
			{ name = "HVT 358 Rastreador Portátil Spark Nano 4.0 ((50% de probabilidad))", description = "GPS HVT 358 Spark Nano 4.0 Portátil ((50% de probabilidad de ser encontrado)), por Viozy", price = 345000 / priceReduce, itemID = 205, itemValue = "HVT 358 Rastreador Portátil Spark Nano 4.0 de Viozy ((50% de probabilidad))" },
			{ name = "Rastreador de Vehículo Oculto 272 Micro ((30% de probabilidad))", description = "GPS HVT 272 Micro, fácil instalación ((30% de probabilidad de ser encontrado)), por Viozy", price = 840000 / priceReduce, itemID = 204, itemValue = "Rastreador de Vehículo Oculto 272 Micro de Viozy ((30% de probabilidad))" },
			{ name = "Rastreador de Vehículo Oculto 315 Pro ((Indetectable))", description = "GPS HVT 315 Pro, fácil instalación ((y indetectable)), por Viozy", price = 2229000 / priceReduce, itemID = 203, itemValue = "Rastreador de Vehículo Oculto 315 Pro de Viozy ((Indetectable))" },
		},
		{
			name = "Neumáticos Descuento",
			{ name = "Access", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1098 },
			{ name = "Virtual", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1097 },
			{ name = "Ahab", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1096 },
			{ name = "Atomic", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1085 },
			{ name = "Trance", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1084 },
			{ name = "Dollar", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1083 },
			{ name = "Import", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1082 },
			{ name = "Grove", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1081 },
			{ name = "Switch", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1080 },
			{ name = "Cutter", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1079 },
			{ name = "Twist", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1078 },
			{ name = "Classic", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1077 },
			{ name = "Wires", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1076 },
			{ name = "Rimshine", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1075 },
			{ name = "Mega", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1074 },
			{ name = "Shadow", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1073 },
			{ name = "Offroad", description = "Neumáticos usados", price = wheelPrice / priceReduce, itemID = 114, itemValue = 1025 },
		}

	},
	{ -- 8
		name = "Tienda Electronica",
		description = "La última tecnología, extremadamente cara, solo para ti.",
		image = "general.png",

		{
			name = "Electronicos",
			{ name = "Teléfono celular", description = "Un teléfono celular elegante y delgado.", price = 800000, itemID = 2 },
			{ name = "Linterna", description = "Ilumina el entorno.", price = 25000, itemID = 145, itemValue = 100 },
			{ name = "Ghettoblaster", description = "Un ghettoblaster negro.", price = 250000, itemID = 54 },
			{ name = "Cámara", description = "Una pequeña cámara analógica negra.", price = 75000, itemID = 115, itemValue = 43 },
			{ name = "Radio", description = "Una radio negra.", price = 50000, itemID = 6 },
			{ name = "Auricular", description = "Un auricular que se puede usar con una radio.", price = 25000, itemID = 88 },
			{ name = "Reloj", description = "¡Nunca fue tan sexy saber la hora!", price = 25000, itemID = 17 },
			{ name = "Reproductor de MP3", description = "Un reproductor de MP3 blanco y elegante. La marca es EyePod.", price = 120000, itemID = 19 },
			{ name = "Juego de química", description = "Un pequeño juego de química.", price = 2000000, itemID = 44 },
			{ name = "Caja fuerte", description = "Una caja fuerte para guardar tus objetos.", price = 500000, itemID = 223, itemValue = "Caja fuerte:2332:50" }, -- El ID del modelo es el de la antigua caja fuerte y la capacidad es de 50 kg.
			--{ name = "GPS", description = "Un sistema GPS para un automóvil.", price = 300, itemID = 67 },
			{ name = "GPS portátil", description = "Dispositivo de posicionamiento global personal, con mapas recientes.", price = 200000, itemID = 111 },
			{ name = "Macbook Pro A1286 Core i7", description = "Un Macbook de última generación para ver correos electrónicos y navegar por Internet.", price = 2200000, itemID = 96 },
			{ name = "TV portátil", description = "Una TV portátil para ver la televisión.", price = 750000, itemID = 104 },
			{ name = "Pase de peaje", description = "Para tu automóvil: te cobra automáticamente al pasar por una caseta de peaje.", price = 400000, itemID = 118 },
			{ name = "Sistema de alarma para vehículos", description = "Protege tu vehículo con una alarma.", price = 1000000, itemID = 130 },
			{ name = "Cargador de batería para automóviles", description = "Puede cargar rápidamente casi todos los tipos de baterías, una excelente opción para mecánicos caseros y pequeñas tiendas.", price = 150000, itemID = 232, itemValue = 1},
			{ name = "Gafas de visión nocturna", description = "Un sistema de visión nocturna robusto, confiable y de alto rendimiento.", price = 4499000, itemID = 115, itemValue = 44 },
			{ name = "Gafas de infrarrojos", description = "Ligeras, resistentes y de alto rendimiento, una opción excepcional para el uso sin manos.", price = 7499000, itemID = 115, itemValue = 45 },
		}
	},
	{ -- 9
		name = "Tienda de Alcohol",
		description = "Todo, desde vodka hasta cerveza y al revés.",
		image = "general.png",

		{
			name = "Alcohol",
			{ name = "Cerveza Ziebrand", description = "La mejor cerveza, importada de Holanda.", price = 7000, itemID = 58, minimum_age = 21 },
			{ name = "Vodka Bastradov", description = "Para tus mejores amigos - Vodka Bastradov.", price = 23000, itemID = 62, minimum_age = 21 },
			{ name = "Whisky Escocés", description = "El mejor whisky escocés, ahora hecho exclusivamente con haggis.", price = 12000, itemID = 63, minimum_age = 21 },
			{ name = "Refresco", description = "Una lata fría de Sprunk.", price = 3000, itemID = 9 },
		}
	},
	{ -- 10
		name = "Tienda de Libros",
		description = "¿Cosas nuevas que aprender? ¡¿Suena divertido?!",
		image = "general.png",

		{
			name = "Libros",
			{ name = "Guía de la Ciudad", description = "Un pequeño folleto de la guía de la ciudad.", price = 15000, itemID = 18 },
			{ name = "Código de Carreteras de Los Santos", description = "Un libro de bolsillo.", price = 10000, itemID = 50 },
			{ name = "Química 101", description = "Un libro académico de tapa dura.", price = 20000, itemID = 51 },
			{ name = "Libro en Blanco", description = "Un libro de tapa dura sin nada escrito en él.", price = 40000, itemID = 178, itemValue = "Libro Nuevo"},
		}
	},
	{ -- 11
		name = "Cafe",
		description = "¿Quieres un poco de chocolate en tu riñon?",
		image = "food.png",

		{
			name = "Comida",
			{ name = "Donut", description = "Donut caliente cubierto de azúcar pegajosa", price = 2100, itemID = 13 },
			{ name = "Galleta", description = "Una galleta de chocolate de lujo", price = 2100, itemID = 14 },
		},
		{
			name = "Bebestibles",
			{ name = "Café", description = "Una pequeña taza de café.", price = 1500, itemID = 83, itemValue = 2 },
			{ name = "Refresco", description = "Una lata fría de Sprunk.", price = 2100, itemID = 9, itemValue = 3 },
			{ name = "Agua", description = "Una botella de agua mineral.", price = 1200, itemID = 15, itemValue = 2 },
		}
	},
	{ -- 12
		name = "Gruta de Papá Noel",
		description = "Ho ho ho Feliz Navidad.",
		image = "general.png",

		{
			name = "Items Navidad",
			{ name = "Regalo de Navidad", description = "¿Qué podría haber dentro?", price = 0, itemID = 94 },
			{ name = "Eggnog", description = "¡Ñam ñam!", price = 0, itemID = 91 },
			{ name = "Pavo", description = "¡Ñam ñam!", price = 0, itemID = 92 },
			{ name = "Pudín de Navidad", description = "¡Ñam ñam!", price = 0, itemID = 93 },
		}
	},
	{ -- 13
		name = "Trabajador penitenciario",
		description = "Ahora que se ve ... vagamente sabroso.",
		image = "general.png",

		{
			name  = "Cosas repugnantes",
			{ name = "Bandeja de Cena Variada", description = "Juguemos al juego de adivinanzas.", price = 0, itemID = 99 },
			{ name = "Pequeño Cartón de Leche", description = "¡Grumos incluidos!", price = 0, itemID = 100 },
			{ name = "Pequeño Cartón de Jugo", description = "¿Sed?", price = 0, itemID = 101 },
		}
	},
	{ -- 14
		name = "Tienda de modificaciones integral",
		description = "¡Cualquier pieza que necesites!",
		image = "general.png",

		-- items to be filled in later
		{
			name = "Partes de Vehiculo"
		}
	},
	{ -- 15
		name = "NPC",
		description = "(( Este es solo un NPC, no está destinado a contener ningún objeto. ))",
		image = "general.png",

		{
			name = "No items"
		}
	},
	{ -- 16
		name = "Ferretería",
		description = "Necesitas algunas herramientas?!",
		image = "general.png",

		{
			name = "Herramientas eléctricas",
			{ name = "Taladro Eléctrico", description = "Un taladro eléctrico operado con batería.", price = 50000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Taladro Eléctrico"} },
			{ name = "Sierra Eléctrica", description = "Una sierra eléctrica con enchufe.", price = 65000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Sierra Eléctrica"} },
			{ name = "Pistola de Clavos Neumática", description = "Una pistola de clavos operada neumáticamente.", price = 80000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Pistola de Clavos Neumática"} },
			{ name = "Pistola de Pintura Neumática", description = "Una pistola de pintura operada neumáticamente.", price = 90000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Pistola de Pintura Neumática"} },
			{ name = "Llave de Aire", description = "Una llave operada neumáticamente.", price = 80000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Llave de Aire"} },
			{ name = "Antorcha", description = "Un juego de antorchas móviles operado con gas natural.", price = 80000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Juego de Antorchas Móviles"} },
			{ name = "Soldador Eléctrico", description = "Un soldador eléctrico operado con electricidad.", price = 80000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Soldador Eléctrico Móvil"} },

		},
		{
			name = "Herramienta de mano",
			{ name = "Martillo", description = "Un martillo de hierro.", price = 25000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Martillo de Hierro"} },
			{ name = "Destornillador Phillips", description = "Un destornillador Phillips.", price = 50000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Destornillador Phillips"} },
			{ name = "Destornillador de Paleta", description = "Un destornillador de paleta.", price = 50000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Destornillador de Paleta"} },
			{ name = "Destornillador Robinson", description = "Un destornillador Robinson.", price = 60000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Destornillador Robinson"} },
			{ name = "Destornillador Torx", description = "Un destornillador Torx.", price = 80000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Destornillador Torx"} },
			{ name = "Alicates de Punta Fina", description = "Alicates.", price = 25000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Alicates de Punta Fina"} },
			{ name = "Palanca", description = "Una gran palanca de hierro.", price = 30000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Palanca de Hierro"} },
			{ name = "Llave para Neumáticos", description = "Una llave para neumáticos.", price = 25000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Llave para Neumáticos"} },
			{ name = "Llave Ajustable", description = "Una llave ajustable.", price = 7000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Llave Ajustable"} },
			{ name = "Llave Inglesa", description = "Una gran llave inglesa.", price = 12000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Llave Inglesa"} },
			{ name = "Llave de Tubo", description = "Una llave de tubo.", price = 74000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Llave de Tubo"} },
			{ name = "Llave de Torque", description = "Una gran llave de torque.", price = 35000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Llave de Torque"} },
			{ name = "Alicates de Presión", description = "Alicates de presión.", price = 12000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Alicates de Presión"} },
			{ name = "Cortacables", description = "Utilizado para cortar cables.", price = 6000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Cortacables"} },
			{ name = "Sierra de Arco", description = "Una sierra de arco.", price = 40000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Sierra de Arco"} },
		},
		{
			name = "Tornillos y clavos",
			{ name = "Tornillos Phillips", description = "Una caja de tornillos Phillips.", price = 3000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Tornillos Phillips (100)"} },
			{ name = "Tornillos de Paleta", description = "Una caja de tornillos de paleta.", price = 3000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Tornillos de Paleta (100)"} },
			{ name = "Tornillos Robinson", description = "Una caja de tornillos Robinson.", price = 3000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Tornillos Robinson (100)"} },
			{ name = "Tornillos Torx", description = "Una caja de tornillos Torx.", price = 3000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Tornillos Torx (100)"} },
			{ name = "Clavos de Hierro", description = "Una caja de clavos de hierro.", price = 2000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Clavos de Hierro (100)"} },
		},
		{
			name = "Misc.",
			{ name = "Compresor de Aire Bosch de 6 Galones", description = "Un compresor de aire Bosch de 6 galones.", price = 300000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Compresor de Aire Bosch de 6 Galones"} },
			{ name = "Guantes", description = "Un par de guantes para usar.", price = 2000, itemID = 270, itemValue = 1 },
			{ name = "Bleach Chlorex", description = "Una botella de blanqueador Chlorex.", price = 13000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Blanqueador Chlorex"} },
			{ name = "Lata de Pintura", description = "Una lata de pintura en el color de tu elección.", price = 10000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Lata de Pintura"} },
			{ name = "Caja de Herramientas", description = "Una caja de herramientas de metal roja.", price = 20000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Caja de Herramientas de Metal Roja"} },
			{ name = "Cubo de Basura de Plástico Rubbermaid", description = "Un cubo de basura de plástico Rubbermaid.", price = 25000, itemID = 80, itemValue = 1, metadata = {['item_name'] = "Cubo de Basura de Plástico Rubbermaid"} },
		}
	},
	{ -- 17
		name = "Tienda Personalizada",
		description = " ",
		image = "general.png",
	},
	{ -- 18
		name = "Faccion Drop NPC - Items Generales",
		description = " ",
		image = "general.png",
	},
	{ -- 19
		name = "Faccion Drop NPC - Armas",
		description = " ",
		image = "general.png",
	},
}

-- some initial updating once you start the resource
function loadLanguages( )
	local shop = g_shops[ 10 ]
	for i = 1, exports['language-system']:getLanguageCount() do
		local ln = exports['language-system']:getLanguageName(i)
		if ln then
			table.insert( shop[1], { name = ln .. " Diccionario", description = "Un Diccionario, útil para aprender " .. ln .. ".", price = 25, itemID = 69, itemValue = i } )
		end
	end
end

addEventHandler( "onResourceStart", resourceRoot, loadLanguages )
addEventHandler( "onClientResourceStart", resourceRoot, loadLanguages )

-- util

function getMetaItemName(item)
	local metaName = type(item.metadata) == 'table' and item.metadata.item_name or nil

	return metaName ~= nil and metaName or ''
end

function checkItemSupplies(shop_type, supplies, itemID, itemValue, itemMetaName)
	if supplies then
		-- regular items
		if (supplies[itemID .. ":" .. (itemValue or 1)] and supplies[itemID .. ":" .. (itemValue or 1)] > 0) then
			return true
		-- generics with meta name
		elseif (supplies[itemID .. ":" .. (itemValue or 1) .. ":" .. itemMetaName] and supplies[itemID .. ":" .. (itemValue or 1) .. ":" .. itemMetaName] > 0) then
			return true
		-- clothes
		elseif (itemID == 16 and supplies[tostring(itemID)] and supplies[tostring(itemID)] > 0) then
			return true
		-- bandanas
		elseif (bandanas[itemID] and supplies["122"] and supplies["122"] > 0) then
			return true
		-- car mods
		elseif (itemID == 114 and vehicle_upgrades[tonumber(itemValue)-999] and vehicle_upgrades[tonumber(itemValue)-999][3] and supplies["114:" .. vehicle_upgrades[tonumber(itemValue)-999][3]] and supplies["114:" .. vehicle_upgrades[tonumber(itemValue)-999][3]] > 0) then
			return true
		end
	end
	return false
end

function getItemFromIndex( shop_type, index, usingStocks, interior )
	local shop = g_shops[ shop_type ]
	if shop then
		if usingStocks and interior then
			local status = getElementData(interior, "status")
			local supplies = fromJSON(status.supplies)
			local govOwned = status.type == 2
			local counter = 1
			for _, category in ipairs(shop) do
				for _, item in ipairs(category) do
					if checkItemSupplies(shop_type, supplies, item.itemID, item.itemValue, getMetaItemName(item)) or govOwned then
						if counter == index then
							return item
						end
						counter = counter + 1
					end
				end
			end
		else
			for _, category in ipairs(shop) do
				if index <= #category then
					return category[index]
				else
					index = index - #category
				end
			end
		end
	end
end

--
--local simplesmallcache = {}
function updateItems( shop_type, race, gender )
	if shop_type == 5 then -- clothes shop
		-- load the shop
		local shop = g_shops[shop_type]

		-- clear all items
		for _, category in ipairs(shop) do
			while #category > 0 do
				table.remove( category, i )
			end
		end

		-- uber complex logic to add skins
		local nat = {}
		local availableskins = fittingskins[gender][race]
		table.sort(availableskins)
		for k, v in ipairs(availableskins) do
			if not restricted_skins[v] then
				table.insert( shop[1], { name = "Colección #" .. v, description = "Click para expandir", price = 50, itemID = 16, itemValue = v, fitting = true } )
				nat[v] = true
			end
		end

		local otherSkins = {}
		for gendr = 0, 1 do
			for rac = 0, 2 do
				if gendr ~= gender or rac ~= race then
					for k, v in pairs(fittingskins[gendr][rac]) do
						if not nat[v] and not restricted_skins[v] then
							table.insert(otherSkins, v)
						end
					end
				end
			end
		end
		table.sort(otherSkins)

		for k, v in ipairs(otherSkins) do
			table.insert( shop[2], { name = "Colección #" .. v, description = "Estos no parecen quedarte bien", price = 50, itemID = 16, itemValue = v } )
		end

		shop[3] = {
			name = 'Bandanas',
			{ name = "Bandana Azul Claro", description = "Un trapo azul claro.", price = 5, itemID = 122 },
			{ name = "Bandana Roja", description = "Un trapo rojo.", price = 5, itemID = 123 },
			{ name = "Bandana Amarilla", description = "Un trapo amarillo.", price = 5, itemID = 124 },
			{ name = "Bandana Morada", description = "Un trapo morado.", price = 5, itemID = 125 },
			{ name = "Bandana Azul", description = "Un trapo azul.", price = 5, itemID = 135 },
			{ name = "Bandana Marrón", description = "Un trapo marrón.", price = 5, itemID = 136 },
			{ name = "Bandana Verde", description = "Un trapo verde.", price = 5, itemID = 158 },
			{ name = "Bandana Naranja", description = "Un trapo naranja.", price = 5, itemID = 168 },
			{ name = "Bandana Negra", description = "Un trapo negro.", price = 5, itemID = 237 },
			{ name = "Bandana Gris", description = "Un trapo gris.", price = 5, itemID = 238 },
			{ name = "Bandana Blanca", description = "Un trapo blanco.", price = 5, itemID = 239 },
		}

		-- simplesmallcache[tostring(race) .. "|" .. tostring(gender)] = shop
	elseif shop_type == 14 then
		-- param (race)= vehicle model
		--[[local c = simplesmallcache["vm"]
		if c then
			return
		end]]

		-- remove old data
		for _, category in ipairs(shop) do
			while #category > 0 do
				table.remove( category, i )
			end
		end

		for v = 1000, 1193 do
			if vehicle_upgrades[v-999] then
				local str = exports['item-system']:getItemDescription( 114, v )

				local p = str:find("%(")
				local vehicleName = ""
				if p then
					vehicleName = str:sub(p+1, #str-1) .. " - "
					str = str:sub(1, p-2)
				end
				if not disabledUpgrades[v] then
					table.insert( shop[1], { name = vehicleName .. ( getVehicleUpgradeSlotName(v) or "Lights" ), description = str, price = vehicle_upgrades[v-999][2], itemID = 114, itemValue = v})
				end
			end
		end
		-- bar battery
		table.insert( shop[1], { name = exports['item-system']:getItemName( 232 ), description = exports['item-system']:getItemDescription( 232, 1 ), price = 130*2, itemID = 232, itemValue = 1} )
	end
end

function getFittingSkins()
	return fittingskins
end


function getDiscount( player, shoptype )
	local discount = 1
	if shoptype == 7 then
		discount = discount * 0.5
	elseif shoptype == 14 then
		discount = discount * 0.5
	end

	if exports.donators:hasPlayerPerk( player, 8 ) then
		discount = discount * 0.8
	end
	return discount
end
