handlingValues = {
	{"Max Speed (Km/h)", 0.1, 3000, ref = 'maxVelocity'},
	{"Acceleration", 0.1, 200, ref = 'engineAcceleration'},
	{"Engine Inertia", 0.1, 30, ref = 'engineInertia'},
	
	{"Suspension Height", -0.375, 0.1, ref = 'suspensionLowerLimit'},
	{"Suspension Bias", 0.05, 0.95, ref = 'suspensionFrontRearBias'},
	{"Suspension Force", 0.01, 3, ref = 'suspensionForceLevel'},
	{"Suspension Damping", 0.01, 0.2, ref = 'suspensionDamping'},
	{"Steering Lock", 0.1, 55, ref = 'steeringLock'},
	
	{"Mass Weight (Kg)", 50, 10000, ref = 'mass'},
	{"Center of Mass X", -1, 1, ref = 'centerOfMassX'},
	{"Center of Mass Y", -1, 1, ref = 'centerOfMassY'},
	{"Center of Mass Z", -20, 1, ref = 'centerOfMassZ'},

	{"Drag Coefficiency", 0.1, 6, ref = 'dragCoeff'},
	{"Braking Power", 0.1, 50, ref = 'brakeDeceleration'},
	{"Braking Bias", 0.1, 1, ref = 'brakeBias'},
	{"Traction Multiplier", 0.1, 50, ref = 'tractionMultiplier'},
	{"Traction Bias", 0.1, 1, ref = 'tractionBias'},
}

handlings = {
	[1]={"mass", mass},
	[2]={"turnMass", turnMass},
	[3]={"dragCoeff", dragCoeff},
	[4]={"centerOfMass", centerOfMass, true},
	[5]={"percentSubmerged", percentSubmerged},
	[6]={"tractionMultiplier", tractionMultiplier},
	[7]={"tractionLoss", tractionLoss},
	[8]={"tractionBias", tractionBias},
	[9]={"numberOfGears", numberOfGears},
	[10]={"maxVelocity", maxVelocity},
	[11]={"engineAcceleration", engineAcceleration},
	[12]={"engineInertia", engineInertia},
	[13]={"driveType", driveType, false, true},
	[14]={"engineType", engineType, false, true},
	[14]={"engineType", engineType, false, true},
	[15]={"brakeDeceleration", brakeDeceleration},
	[16]={"brakeBias", brakeBias},
	[17]={"ABS", ABS},
	[18]={"steeringLock", steeringLock},
	[19]={"suspensionForceLevel", suspensionForceLevel},
	[20]={"suspensionDamping", suspensionDamping},
	[21]={"suspensionHighSpeedDamping", suspensionHighSpeedDamping},
	[22]={"suspensionUpperLimit", suspensionUpperLimit},
	[23]={"suspensionLowerLimit", suspensionLowerLimit},
	[24]={"suspensionFrontRearBias", suspensionFrontRearBias},
	[25]={"suspensionAntiDiveMultiplier", suspensionAntiDiveMultiplier},
	[26]={"seatOffsetDistance", seatOffsetDistance},
	[27]={"collisionDamageMultiplier", collisionDamageMultiplier},
	[28]={"monetary", monetary},
	[29]={"modelFlags", modelFlags},
	[30]={"handlingFlags", handlingFlags},
	[31]={"headLight", headLight, false, true},
	[32]={"tailLight", tailLight, false, true},
	[33]={"animGroup", animGroup}
}