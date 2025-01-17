-----------------------------------
-- Area: Upper Jeuno
--  NPC: Brutus
-- Starts Quest: Chocobo's Wounds, Save My Son, Path of the Beastmaster, Wings of gold, Scattered into Shadow, Chocobo on the Loose!
-- !pos -55 8 95 244
-----------------------------------
package.loaded["scripts/zones/Upper_Jeuno/TextIDs"] = nil
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/wsquest")
require("scripts/zones/Upper_Jeuno/TextIDs")
-----------------------------------

local wsQuest = dsp.wsquest.decimation

function onTrade(player,npc,trade)

    local wsQuestEvent = dsp.wsquest.getTradeEvent(wsQuest,player,trade)

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player,npc)

    local wsQuestEvent = dsp.wsquest.getTriggerEvent(wsQuest,player)
    local chocoboOnTheLoose = player:getQuestStatus(JEUNO,CHOCOBO_ON_THE_LOOSE)
    local chocoboOnTheLooseStatus = player:getVar("ChocoboOnTheLoose")
    local ChocobosWounds = player:getQuestStatus(JEUNO,CHOCOBO_S_WOUNDS)
    local saveMySon = player:getQuestStatus(JEUNO,SAVE_MY_SON)
    local wingsOfGold = player:getQuestStatus(JEUNO,WINGS_OF_GOLD)
    local scatIntoShadow = player:getQuestStatus(JEUNO,SCATTERED_INTO_SHADOW)
    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    if wsQuestEvent ~= nil then
        player:startEvent(wsQuestEvent)
    elseif (player:getMainLvl() >= 20 and ChocobosWounds ~= QUEST_COMPLETED) then
        local chocoFeed = player:getVar("ChocobosWounds_Event")

        if (ChocobosWounds == QUEST_AVAILABLE) then
            player:startEvent(71)
        elseif (chocoFeed == 1) then
            player:startEvent(65)
        elseif (chocoFeed == 2) then
            player:startEvent(66)
        else
            player:startEvent(102)
        end
    elseif (ChocobosWounds == QUEST_COMPLETED and saveMySon == QUEST_AVAILABLE) then
        player:startEvent(22)
    elseif (saveMySon == QUEST_COMPLETED and player:getQuestStatus(JEUNO,PATH_OF_THE_BEASTMASTER) == QUEST_AVAILABLE) then
        player:startEvent(70)
    elseif (mLvl >= AF1_QUEST_LEVEL and mJob == 9 and wingsOfGold == QUEST_AVAILABLE) then
        if (player:getVar("wingsOfGold_shortCS") == 1) then
            player:startEvent(137) -- Start Quest "Wings of gold" (Short dialog)
        else
            player:setVar("wingsOfGold_shortCS",1)
            player:startEvent(139) -- Start Quest "Wings of gold" (Long dialog)
        end
    elseif (wingsOfGold == QUEST_ACCEPTED) then
        if (player:hasKeyItem(dsp.ki.GUIDING_BELL) == false) then
            player:startEvent(136)
        else
            player:startEvent(138) -- Finish Quest "Wings of gold"
        end
    elseif (wingsOfGold == QUEST_COMPLETED and mLvl < AF2_QUEST_LEVEL and mJob == 9) then
        player:startEvent(134) -- Standard dialog after "Wings of gold"
    elseif (scatIntoShadow == QUEST_AVAILABLE and mLvl >= AF2_QUEST_LEVEL and mJob == 9) then
        if (player:getVar("scatIntoShadow_shortCS") == 1) then
            player:startEvent(143)
        else
            player:setVar("scatIntoShadow_shortCS",1)
            player:startEvent(141)
        end
    elseif (scatIntoShadow == QUEST_ACCEPTED) then
        local scatIntoShadowCS = player:getVar("scatIntoShadowCS")
        if (player:hasKeyItem(dsp.ki.AQUAFLORA1) or player:hasKeyItem(dsp.ki.AQUAFLORA2) or player:hasKeyItem(dsp.ki.AQUAFLORA3)) then
            player:startEvent(142)
        elseif (scatIntoShadowCS == 0) then
            player:startEvent(144)
        elseif (scatIntoShadowCS == 1) then
            player:startEvent(149)
        elseif (scatIntoShadowCS == 2) then
            player:startEvent(135)
        end
    elseif (scatIntoShadow == QUEST_COMPLETED) then
        player:startEvent(151)
    elseif (player:getQuestStatus(JEUNO,PATH_OF_THE_BEASTMASTER) == QUEST_COMPLETED) then
        player:startEvent(20)
    elseif (chocoboOnTheLoose == QUEST_AVAILABLE) then
        player:startEvent(10093)
    elseif (chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStatus == 0) then
        player:startEvent(10094)
    elseif (chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStatus == 2) then
        player:startEvent(10095)
    elseif (chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStatus == 3) then
        player:startEvent(10099)
    elseif (chocoboOnTheLoose == QUEST_ACCEPTED and (chocoboOnTheLooseStatus == 5 or chocoboOnTheLooseStatus == 6)) then
        player:startEvent(10100)
    elseif (chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStatus == 7 and player:needToZone() == false and (player:getVar("ChocoboOnTheLooseDay") < VanadielDayOfTheYear() or player:getVar("ChocoboOnTheLooseYear") < VanadielYear())) then
        player:startEvent(10109)
    else
        player:startEvent(66, player:getMainLvl())
    end
end

function onEventFinish(player,csid,option)

    if (csid == 71 and option == 1) then
        player:addQuest(JEUNO,CHOCOBO_S_WOUNDS)
        player:setVar("ChocobosWounds_Event",1)
    elseif (csid == 70) then
        player:addQuest(JEUNO,PATH_OF_THE_BEASTMASTER)
        player:addTitle(dsp.title.ANIMAL_TRAINER)
        player:unlockJob(dsp.job.BST)
        player:messageSpecial(YOU_CAN_NOW_BECOME_A_BEASTMASTER)
        player:addFame(JEUNO, 30)
        player:completeQuest(JEUNO,PATH_OF_THE_BEASTMASTER)
    elseif ((csid == 139 or csid == 137) and option == 1) then
        player:addQuest(JEUNO,WINGS_OF_GOLD)
        player:setVar("wingsOfGold_shortCS",0)
    elseif (csid == 138) then
        if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,16680)
        else
            player:delKeyItem(dsp.ki.GUIDING_BELL)
            player:addItem(16680)
            player:messageSpecial(ITEM_OBTAINED,16680) -- Barbaroi Axe
            player:addFame(JEUNO,AF1_FAME)
            player:completeQuest(JEUNO,WINGS_OF_GOLD)
        end
    elseif ((csid == 143 or csid == 141) and option == 1) then
        player:addQuest(JEUNO,SCATTERED_INTO_SHADOW)
        player:setVar("scatIntoShadow_shortCS",0)
        player:addKeyItem(dsp.ki.AQUAFLORA1)
        player:addKeyItem(dsp.ki.AQUAFLORA2)
        player:addKeyItem(dsp.ki.AQUAFLORA3)
        player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.AQUAFLORA1);
    elseif (csid == 144) then
        player:setVar("scatIntoShadowCS",1)
    elseif (csid == 135) then
        if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,14097)
        else
            player:setVar("scatIntoShadowCS",0)
            player:addItem(14097);
            player:messageSpecial(ITEM_OBTAINED,14097) -- Beast Gaiters
            player:addFame(JEUNO,AF2_FAME)
            player:completeQuest(JEUNO,SCATTERED_INTO_SHADOW)
        end
    elseif (csid == 10093) then
        player:addQuest(JEUNO,CHOCOBO_ON_THE_LOOSE)
    elseif (csid == 10094) then
        player:setVar("ChocoboOnTheLoose", 1)
    elseif (csid == 10095) then
        player:setVar("ChocoboOnTheLoose", 3)
    elseif (csid == 10099) then
        player:setVar("ChocoboOnTheLoose", 4)
    elseif (csid == 10100) then
        player:setVar("ChocoboOnTheLoose", 7)
        player:setVar("ChocoboOnTheLooseDay", VanadielDayOfTheYear())
        player:setVar("ChocoboOnTheLooseYear", VanadielYear())
        player:needToZone(true)
    elseif (csid == 10109) then
        player:setVar("ChocoboOnTheLoose", 0)
        player:setVar("ChocoboOnTheLooseDay", 0)
        player:setVar("ChocoboOnTheLooseYear", 0)
        player:addFame(JEUNO, 30)
        player:addItem(2317)
        player:messageSpecial(ITEM_OBTAINED,2317) -- Chocobo Egg (a bit warm)
        player:completeQuest(JEUNO,CHOCOBO_ON_THE_LOOSE)
    else
        dsp.wsquest.handleEventFinish(wsQuest,player,csid,option,DECIMATION_LEARNED)
    end
end
