
ENHANCE_X=350
ENHANCE_Y_3=300
ENHANCE_Y_15=480
ENHANCE_Y_30=660
ENHANCE_FUZZY_NUM=70

function main()
    mSleep(3000);
    -- snapshotScreen("/var/touchelf/x.bmp");
    -- snapshotRegion("/var/touchelf/x1.bmp",528,70,548,110);
    -- snapshotRegion("/var/touchelf/x2.bmp",528,310,548,350);
    -- snapshotRegion("/var/touchelf/x3.bmp",528,550,548,590);
    -- snapshotRegion("/var/touchelf/x4.bmp",528,790,548,830);
    -- x, y =findImageInRegionFuzzy("/private/var/touchelf/scripts/bmp/npc1.bmp",80,528,60,570,120);
    -- notifyMessage(x);
    -- notifyMessage(y);
    -- r,g,b = getColorRGB(520, 240);
    findEnhanceColor();
    -- logDebug(a .. " " .. c .. " " .. e);
    -- logDebug(b .. " " .. d .. " " .. f);
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

function findEnhanceColor()
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_3);
    color3 = getColorHuman(r, g, b);
    color3hex = rgb2Hex(r, g, b);
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_15);
    color15 = getColorHuman(r, g, b);
    color15hex = rgb2Hex(r, g, b);
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_30);
    color30 = getColorHuman(r, g, b);
    color30hex = rgb2Hex(r, g, b);

    logDebug("find colors: " .. color3hex .. " " .. color15hex .. " " .. color30hex);
    logDebug("find colors: " .. color3 .. " " .. color15 .. " " .. color30);
    
    return color3, color15, color30;
end

function getColorHuman(r, g, b)
    -- ff0000
    if r > 127 and g < 127 and b < 127 then
        return 'red';
    end
    -- 00ff00
    if r < 127 and g > 127 and b < 127 then
        return 'green';
    end
    -- 0000ff
    -- exception of g
    if r < 127 and g > 127 and b > 127 then
        return 'blue';
    end
    -- ffff00
    if r > 127 and g > 127 and b < 127 then
        return 'yellow';
    end
    -- ff00ff
    if r > 127 and g < 127 and b > 127 then
        return 'purple';
    end

    logDebug('color not recognized');

    return 'wrong';
end

function hex(n)
    if n > 255 then
        n = 255;
    end
    return lpad(string.format("%x", n));
end

function rgb2Hex(r, g, b)
    return hex(r) .. hex(g) .. hex(b);
end

function lpad(r)
    if string.len(r) == 1 then
        r = "0" .. r;
    end
    return r;
end