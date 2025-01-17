-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Nanaa Mihgo
-----------------------------------
package.loaded["scripts/zones/Chamber_of_Oracles/TextIDs"] = nil
-----------------------------------
require("scripts/zones/Chamber_of_Oracles/TextIDs")
require("scripts/mixins/job_special")
require("scripts/globals/status")
-----------------------------------

local offsets = {1, 2}

function onMobInitialize(mob)
end

function onMobSpawn(mob)
end

function onMobEngaged(mob,target)
end

function onMobFight(mob, target)

    if (mob:hasStatusEffect(dsp.effect.PERFECT_DODGE) == false and mob:actionQueueEmpty() == true) then

        local twohourTime = mob:getLocalVar("twohourTime")
        local spawnTime = mob:getLocalVar("spawnTime")

        if (twohourTime == 0) then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end
		
		if (spawnTime == 0) then
            spawnTime = math.random(3, 5)
            mob:setLocalVar("spawnTime", spawnTime)
        end

        if (mob:getBattleTime()/15 > twohourTime) then
            mob:useMobAbility(693)
            mob:setLocalVar("twohourTime", (mob:getBattleTime()/15)+20)
			
        elseif (mob:getBattleTime()/15 > spawnTime) then
            for i, offset in ipairs(offsets) do
                if (GetMobAction(mob:getID()+offset) == dsp.act.SPAWN or GetMobAction(mob:getID()+offset) == dsp.act.NONE) then
                    local pet = SpawnMob(17465415, 60):updateEnmity(target)
                    local pet = SpawnMob(17465416, 60):updateEnmity(target)
                    break
				end
            end
            mob:setLocalVar("spawnTime", (mob:getBattleTime()/15)+4);
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
    end
end

function onMobDespawn(mob)
end
