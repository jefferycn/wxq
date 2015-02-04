package.path=package.path .. ";/var/touchelf/scripts/blood/?.lua"
require "core"

function main()

-- mSleep(3000);
-- snapshotScreen("/var/touchelf/x.bmp");
count = 0;

-- r,g,b = getColorRGB(70,520);
-- logDebug(r .. " " .. g .. " " .. b);
-- r,g,b = getColorRGB(200,480);
-- logDebug(r .. " " .. g .. " " .. b);

    mSleep(1000);
    while count < 600000 do
        count = count + 1;
        click(450, 20, 0, 0);
        mSleep(300);
        -- 修炼
        if findBtn(0x092e34, 450, 300) then
            clickBtn(0x21947e, 160, 485);
        end
        clickBtn(0x1d776b, 70, 520);
        clickBtn(0x539792, 200, 480);
    end
end