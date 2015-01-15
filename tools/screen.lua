
ENHANCE_X=350
ENHANCE_Y_3=300
ENHANCE_Y_15=480
ENHANCE_Y_30=660
ENHANCE_FUZZY_NUM=70

function main()
    -- mSleep(3000);
    -- snapshotScreen("/var/touchelf/x.bmp");
    -- snapshotRegion("/var/touchelf/x1.bmp",528,70,548,110);
    -- snapshotRegion("/var/touchelf/x2.bmp",528,310,548,350);
    -- snapshotRegion("/var/touchelf/x3.bmp",528,550,548,590);
    -- snapshotRegion("/var/touchelf/x4.bmp",528,790,548,830);
    -- x, y =findImageInRegionFuzzy("/private/var/touchelf/scripts/bmp/npc1.bmp",80,528,60,570,120);
    -- notifyMessage(x);
    -- notifyMessage(y);
    -- r,g,b = getColorRGB(520, 240);
    a, b, c, d, e, f = findEnhanceColor();
    logDebug(a .. " " .. c .. " " .. e);
    logDebug(b .. " " .. d .. " " .. f);
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
    logDebug('find \\e]4;1;rgb:' .. hex(r) .. "/" .. hex(g) .. "/" .. hex(b) .. '\\e\\\\\\e[31m██\\e[m\\n');
    color3min, color3max = getColorFuzzy(r, g, b);
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_15);
    color15min, color15max = getColorFuzzy(r, g, b);
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_30);
    color30min, color30max = getColorFuzzy(r, g, b);
    
    return color3min ,color3max ,color15min ,color15max ,color30min ,color30max;
end

function getColorFuzzy(r, g, b)
    r_min = r * (1 - (100 - ENHANCE_FUZZY_NUM) / 1000);
    r_max = r * (1 + (200 - ENHANCE_FUZZY_NUM) / 1000);
    g_min = g * (1 - (100 - ENHANCE_FUZZY_NUM) / 1000);
    g_max = g * (1 + (200 - ENHANCE_FUZZY_NUM) / 1000);
    b_min = b * (1 - (100 - ENHANCE_FUZZY_NUM) / 1000);
    b_max = b * (1 + (200 - ENHANCE_FUZZY_NUM) / 1000);

    return rgb2Hex(r_min, g_min, b_min), rgb2Hex(r_max, g_max, b_max);
end

function hex(n)
    if n > 255 then
        n = 255;
    end
    return lpad(string.format("%x", n));
end

function rgb2Hex(r, g, b)
    return "0x" .. hex(r) .. hex(g) .. hex(b);
end

function lpad(r)
    if string.len(r) == 1 then
        r = "0" .. r;
    end
    return r;
end