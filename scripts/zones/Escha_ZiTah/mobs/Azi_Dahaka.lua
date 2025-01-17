-----------------------------------
-- Area: Escha-Zi'Tah (288)
-- HNM: Azi Dahaka (17957397)
-----------------------------------
package.loaded["scripts/zones/Escha_ZiTah/TextIDs"] = nil
-----------------------------------
require("scripts/zones/Escha_ZiTah/TextIDs")
require("scripts/mixins/job_special")
require("scripts/globals/status")
-----------------------------------
local offsets = {1, 3, 5, 2, 4, 6}

function onMobInitialize(mob)
end

function onMobSpawn(mob)
end

function onMobEngaged(mob,target)
end

function onMobFight(mob, target)

    if mob:actionQueueEmpty() == true then

        local spawnTime = mob:getLocalVar("spawnTime")

		if (spawnTime == 0) then
            spawnTime = math.random(3, 5)
            mob:setLocalVar("spawnTime", spawnTime)
        end
			
        if (mob:getBattleTime()/15 > spawnTime) then
            for i, offset in ipairs(offsets) do
                if (GetMobAction(mob:getID()+offset) == dsp.act.SPAWN or GetMobAction(mob:getID()+offset) == dsp.act.NONE) then
                    local pet = SpawnMob(mob:getID()+offset, 120):updateEnmity(target)
					local pet = SpawnMob(mob:getID()+offset+1, 120):updateEnmity(target)
                    break
				end
            end
            mob:setLocalVar("spawnTime", (mob:getBattleTime()/15)+4)
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)

    mob:resetLocalVars()
end

function onMobDeath(mob, player, isKiller)

    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID()+offset)
        DespawnMob(mob:getID()+offset+1)
    end

    local dahaAtma = player:hasKeyItem(dsp.ki.ATMA_OF_THE_RAPID_REPTILIAN)
	
    if dahaAtma == true then
        return
    elseif dahaAtma == false then
        player:addKeyItem(dsp.ki.ATMA_OF_THE_RAPID_REPTILIAN)
        player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.ATMA_OF_THE_RAPID_REPTILIAN)
    end
end

function onMobDespawn(mob)
end
