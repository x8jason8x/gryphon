-----------------------------------
-- Area: Ifrit's Cauldron (205)
--  NPC: qm3 (???)
-- Quests: Blood and Glory (Retribution WSNM "Cailleach Bheur")
-- !pos 119 20 144 205
-----------------------------------
package.loaded["scripts/zones/Ifrits_Cauldron/TextIDs"] = nil
-----------------------------------
require("scripts/globals/wsquest")
require("scripts/zones/Ifrits_Cauldron/TextIDs")
require("scripts/zones/Ifrits_Cauldron/MobIDs")

function onTrigger(player,npc)
    dsp.wsquest.handleQmTrigger(dsp.wsquest.retribution,player,CAILLEACH_BHEUR)
end
