require "Farming/farming_vegetableconf"
require "Farming/SFarmingSystem"

ModFarm = ModFarm or {};

ModFarm.growNext = function(planting,nextGrowing,modifier)
	modifier = modifier or 1;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	if(water >= 0 and diseaseLvl >= 0) then
		planting.nextGrowing = calcNextGrowing(nextGrowing,modifier * farming_vegetableconf.props[planting.typeOfSeed].timeToGrow + water + diseaseLvl);
		planting:setObjectName(farming_vegetableconf.getObjectName(planting))
		planting:setSpriteName(farming_vegetableconf.getSpriteName(planting))
		return true;
	else
		badPlant(water, nil, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		return false;
	end

end

ModFarm.harvest = function(luaObject, player,FarmSys)
	local props = farming_vegetableconf.props[luaObject.typeOfSeed]
	local numberOfVeg = getVegetablesNumber(props.minVeg, props.maxVeg, props.minVegAutorized, props.maxVegAutorized, luaObject)
	if player then
		player:sendObjectChange('addItemOfType', { type = props.vegetableName, count = numberOfVeg })
	end

	if luaObject.hasSeed and player then
		player:sendObjectChange('addItemOfType', { type = props.seedName, count = (props.seedPerVeg * numberOfVeg) })
	end

	luaObject.hasVegetable = false
	luaObject.hasSeed = false

	-- the strawberrie don't disapear, it goes on phase 2 again
	if luaObject.typeOfSeed == "Strawberry plant" then
		luaObject.nbOfGrow = 1
		FarmSys:growPlant(luaObject, nil, true)
		luaObject:saveData()
	else
		FarmSys:removePlant(luaObject)
	end
end

