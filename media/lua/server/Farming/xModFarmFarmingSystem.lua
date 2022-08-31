require "Farming/SFarmingSystem"
require "Farming/SPlantGlobalObject"
require "Farming/farming_vegetableconf"
require "Farming/SPlantGlobalObject"


if isClient() then return end

local stock_growPlant = SFarmingSystem.growPlant;
local stock_harvest = SFarmingSystem.harvest;
local stock_rottenThis = SPlantGlobalObject.rottenThis;

function SFarmingSystem:growPlant(luaObject, nextGrowing, updateNbOfGrow)
	if(luaObject.state == "seeded") then
		local new = luaObject.nbOfGrow <= 0
		if luaObject.typeOfSeed ~= nil then
			if not farming_vegetableconf.props[luaObject.typeOfSeed].ModFarmCrop then
				return stock_growPlant(self, luaObject, nextGrowing, updateNbOfGrow)
			end
			if farming_vegetableconf.props[luaObject.typeOfSeed].growCode then
				local growCode = farming_vegetableconf.props[luaObject.typeOfSeed].growCode
				luaObject = assert(loadstring('return '..growCode..'(...)'))(luaObject, nextGrowing, updateNbOfGrow)
			end
		end

		if not new and luaObject.nbOfGrow > 0 then
			self:diseaseThis(luaObject, true)
		end
		luaObject.nbOfGrow = luaObject.nbOfGrow + 1
	end
end


function SFarmingSystem:harvest(luaObject, player)
	local props = farming_vegetableconf.props[luaObject.typeOfSeed]
	if not props.ModFarmCrop then
		return stock_harvest(self, luaObject, player);
	end
	if props.harvestCode ~= nil then
			local harvestCode = props.harvestCode
			assert(loadstring('return '..harvestCode..'(...)'))(luaObject, player, self)
		return;
	end
	ModFarm.harvest(luaObject,player,self)
end


function SPlantGlobalObject:rottenThis()
	if not farming_vegetableconf.props[self.typeOfSeed].ModFarmCrop then
		return stock_rottenThis(self);
	end
	local texture = farming_vegetableconf.sprite[self.typeOfSeed][#farming_vegetableconf.sprite[self.typeOfSeed]]
	
	self:setSpriteName(texture)
	self.state = "rotten"
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
end

