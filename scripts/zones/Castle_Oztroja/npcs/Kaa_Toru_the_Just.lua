-----------------------------------
-- Area: Castle Oztroja
--  NPC: Kaa Toru the Just
-- Type: Mission NPC [ Windurst Mission 6-2 NPC ]~
-- !pos -100.188 -62.125 145.422 151
-----------------------------------
package.loaded["scripts/zones/Castle_Oztroja/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Castle_Oztroja/TextIDs");
require("scripts/globals/keyitems");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    if (player:getCurrentMission(WINDURST) == SAINTLY_INVITATION and player:getVar("MissionStatus") == 2) then
        player:startEvent(45,0,200);
    else
        player:startEvent(46);
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 45) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,13134);
        else
            player:delKeyItem(dsp.ki.BALGA_CHAMPION_CERTIFICATE);
            player:addKeyItem(dsp.ki.HOLY_ONES_OATH);
            player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.HOLY_ONES_OATH);
            player:addItem(13134); -- Ashura Necklace
            player:messageSpecial(ITEM_OBTAINED,13134);
            player:setVar("MissionStatus",3);
        end
    end
end;
