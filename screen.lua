function main()
    mSleep(1000);
    -- snapshotScreen("/var/touchelf/failed.bmp");
    -- snapshotRegion("/var/touchelf/15.bmp",350,470,360,480);
    -- snapshotRegion("/var/touchelf/5.bmp",350,350,360,360);
    -- x, y =findImageInRegionFuzzy("/private/var/touchelf/scripts/bmp/npc1.bmp",80,528,60,570,120);
    -- notifyMessage(x);
    -- notifyMessage(y);
    r,g,b = getColorRGB(205,329);
    logDebug(r .. " " .. g .. " " .. b);
    -- r,g,b = getColorRGB(350,470);
    -- logDebug(r .. " " .. g .. " " .. b);
    -- r,g,b = getColorRGB(350,350);
    -- logDebug(r .. " " .. g .. " " .. b);
    -- x, y =findColorInRegion(0xdc5fa1,350,670,350,670);
    -- notifyMessage(x .. ", " .. y);
    -- x, y =findColorInRegion(0xd2bb74,143,465,143,465);
    -- notifyMessage(x .. ", " .. y);
    -- x, y =findColorInRegion(0x74575b,143,685,143,685);
    -- notifyMessage(x .. ", " .. y);
end