require "Farming/farming_vegetableconf"
require "Farming/SFarmingSystem"

ModFarm = ModFarm or {};


ModFarm.growSugarBeet = function(planting, nextGrowing, updateNbOfGrow)
	local nbOfGrow = planting.nbOfGrow;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local waterMax = farming_vegetableconf.calcWater(planting.waterLvl, planting.waterNeededMax);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	if(nbOfGrow <= 0) then -- initial
		nbOfGrow = 0;
		planting.nbOfGrow = 0;
		planting = growNext(planting, farming_vegetableconf.getSpriteName(planting), farming_vegetableconf.getObjectName(planting), nextGrowing, farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);
		planting.waterNeeded = 75;
	elseif (nbOfGrow <= 2) then -- sprout
		if ModFarm.growNext(planting,nextGrowing) then
			planting.waterNeeded = farming_vegetableconf.props[planting.typeOfSeed].waterLvl;
			planting.waterNeededMax = farming_vegetableconf.props[planting.typeOfSeed].waterLvlMax;
		end
	elseif (nbOfGrow <= 4) then -- young
		ModFarm.growNext(planting,nextGrowing);
	elseif (nbOfGrow == 5) then -- mature
		ModFarm.growNext(planting,nextGrowing);
	elseif (nbOfGrow == 6) then -- mature blooming
		if ModFarm.growNext(planting,nextGrowing) then
			planting.hasVegetable = true;
			planting.hasSeed = true;
		end
	elseif (planting.state ~= "rotten") and (not getActivatedMods():contains("FarmingNeverRot")) then -- rotten
		planting:rottenThis()
	end

	return planting;
end


ModFarm.harvestSugarBeet = function(luaObject, player,FarmSys)
	local props = farming_vegetableconf.props[luaObject.typeOfSeed];
	local numberOfVeg = getVegetablesNumber(props.minVeg, props.maxVeg, props.minVegAutorized, props.maxVegAutorized, luaObject);
	if player and luaObject.nbOfGrow <= 8 and luaObject.hasVegetable then
		player:sendObjectChange('addItemOfType', { type = props.vegetableName, count = numberOfVeg });
		luaObject.hasVegetable = false
	end
	if luaObject.hasSeed and player then
		player:sendObjectChange('addItemOfType', { type = props.seedName, count = (props.seedPerVeg * numberOfVeg) });
		luaObject.hasSeed = false
	end
	FarmSys:removePlant(luaObject);
end

