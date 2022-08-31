local stock_getObjectName = farming_vegetableconf.getObjectName;

local ANL_plantNames = {["ANLSugarBeet"]=true};

farming_vegetableconf.getObjectName = function(plant)
	if not ANL_plantNames[plant.typeOfSeed] then
		return stock_getObjectName(plant);
	end
	
	if plant.state == "plow" then return getText("Farming_Plowed_Land") end
	if plant.state == "destroy" then return getText("Farming_Destroyed") .. " " .. getText("Farming_" .. plant.typeOfSeed) end
	if plant.state == "dry" then return getText("Farming_Receding") .. " " .. getText("Farming_" .. plant.typeOfSeed) end
	if plant.state == "rotten" then return getText("Farming_Rotten") .. " " .. getText("Farming_" .. plant.typeOfSeed) end
	if plant.nbOfGrow <= 1 then
		return getText("Farming_Seedling") .. " " .. getText("Farming_" ..plant.typeOfSeed);
	elseif plant.nbOfGrow <= 4 then
		return getText("Farming_Young") .. " " .. getText("Farming_" ..plant.typeOfSeed);
	elseif plant.nbOfGrow == 5 then
		if plant.typeOfSeed == "ANLSugarBeet" then
			return getText("Farming_In_bloom") .. " " .. getText("Farming_" ..plant.typeOfSeed);
		else
			return getText("Farming_Ready_for_Harvest") .. " " .. getText("Farming_" ..plant.typeOfSeed);
		end
	elseif plant.nbOfGrow == 6 then
		if plant.typeOfSeed == "ANLSugarBeet" then
			return getText("Farming_Ready_for_Harvest") .. " " .. getText("Farming_" ..plant.typeOfSeed);
		else
			return getText("Farming_Seed-bearing") .. " " .. getText("Farming_" ..plant.typeOfSeed);
		end
	end
	return "Mystery Plant"
end

--Icons

farming_vegetableconf.icons["ANLSugarBeet"] = "Item_SugarBeet";

-- Sugar Beet

farming_vegetableconf.props["ANLSugarBeet"] = farming_vegetableconf.props["ANLSugarBeet"] or {}
farming_vegetableconf.props["ANLSugarBeet"].ModFarmCrop = true;
farming_vegetableconf.props["ANLSugarBeet"].seedsRequired = 4;
farming_vegetableconf.props["ANLSugarBeet"].texture = "anl_sugarbeet_07";
farming_vegetableconf.props["ANLSugarBeet"].waterLvl = 45;
farming_vegetableconf.props["ANLSugarBeet"].timeToGrow = ZombRand(56,62);
farming_vegetableconf.props["ANLSugarBeet"].vegetableName = "ANL.SugarBeet";
farming_vegetableconf.props["ANLSugarBeet"].seedName = "ANL.SugarBeetSeed";
farming_vegetableconf.props["ANLSugarBeet"].growCode = "ModFarm.growSugarBeet";
farming_vegetableconf.props["ANLSugarBeet"].harvestCode = "ModFarm.harvestSugarBeet";
farming_vegetableconf.props["ANLSugarBeet"].seedPerVeg = 1;
farming_vegetableconf.props["ANLSugarBeet"].minVeg = 2;
farming_vegetableconf.props["ANLSugarBeet"].maxVeg = 6;
farming_vegetableconf.props["ANLSugarBeet"].minVegAutorized = 6;
farming_vegetableconf.props["ANLSugarBeet"].maxVegAutorized = 8;
farming_vegetableconf.props["ANLSugarBeet"].waterConsumption = 2;
if (getActivatedMods():contains("Hydrocraft")) then
	farming_vegetableconf.props["ANLSugarBeet"].waterLvlMax = 100;
	farming_vegetableconf.props["ANLSugarBeet"].minTemp = 5;
	farming_vegetableconf.props["ANLSugarBeet"].bestTemp = 15;
	farming_vegetableconf.props["ANLSugarBeet"].maxTemp = 30;
	farming_vegetableconf.props["ANLSugarBeet"].plantWithFruit = false;
	farming_vegetableconf.props["ANLSugarBeet"].damageFromStorm = false;
	farming_vegetableconf.props["ANLSugarBeet"].multiHarvest = false;
	farming_vegetableconf.props["ANLSugarBeet"].vegetableName2 = "";
	farming_vegetableconf.props["ANLSugarBeet"].numberOfVegetables2 = 0;
end

farming_vegetableconf.sprite["ANLSugarBeet"] = {
"anl_sugarbeet_0",
"anl_sugarbeet_1",
"anl_sugarbeet_2",
"anl_sugarbeet_3",
"anl_sugarbeet_4",
"anl_sugarbeet_5",
"anl_sugarbeet_6",
"anl_sugarbeet_7",
}
