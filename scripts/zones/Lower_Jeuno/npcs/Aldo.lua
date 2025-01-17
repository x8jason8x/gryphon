-----------------------------------
-- Area: Lower Jeuno
--  NPC: Aldo
-- Involved in Mission: Magicite, Return to Delkfutt's Tower (Zilart)
-- !pos 20 3 -58 245
-----------------------------------
package.loaded["scripts/zones/Lower_Jeuno/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Lower_Jeuno/TextIDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)

    local ZilartMission = player:getCurrentMission(ZILART);
    local ZilartStatus = player:getVar("ZilartStatus");

    if (player:hasKeyItem(dsp.ki.LETTERS_TO_ALDO)) then
        player:startEvent(152);
    elseif (player:getCurrentMission(player:getNation()) == 13 and player:getVar("MissionStatus") == 3) then
        player:startEvent(183);
    elseif (ZilartMission == RETURN_TO_DELKFUTTS_TOWER and ZilartStatus == 0) then
        player:startEvent(104);
    elseif (ZilartMission == THE_SEALED_SHRINE and ZilartStatus == 1) then
        player:startEvent(111);
    elseif (player:getCurrentMission(ASA) == SUGAR_COATED_SUBTERFUGE) then
        player:startEvent(10100);
    elseif (player:getCurrentMission(ASA) == ROMANCING_THE_CLONE) then
        player:startEvent(10101);
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 152) then
        player:delKeyItem(dsp.ki.LETTERS_TO_ALDO);
        player:addKeyItem(dsp.ki.SILVER_BELL);
        player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.SILVER_BELL);
        player:setVar("MissionStatus",3);
    elseif (csid == 104) then
        player:setVar("ZilartStatus",1);
    elseif (csid == 10100) then
	    player:completeMission(ASA,SUGAR_COATED_SUBTERFUGE);
		player:addMission(ASA,SHANTOTTO_IN_CHAINS);
    elseif (csid == 10101) then
	    player:completeMission(ASA,ROMANCING_THE_CLONE);
		player:addMission(ASA,SISTERS_IN_ARMS);
    end
end;
