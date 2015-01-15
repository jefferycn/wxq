SCREEN_RESOLUTION="640x960"
SCREEN_COLOR_BITS=32

debug=0
count=1
round=1
saveStars=0
protecter=0
-- 0 default, 1 blood first, 2 force first
mode=0

REGION_SIZE=2

-- purple,red,yellow,blue,green
status={};

FUZZY_NUM=98
ENHANCE_FUZZY_NUM=60

BLOOD_BTN=0xE26554
BLOOD_BTN_X=130
BLOOD_BTN_Y=260
HARD_BTN=0xE86549
HARD_BTN_X=130
HARD_BTN_Y=480
NORMAL_BTN=0xE36554
NORMAL_BTN_X=130
NORMAL_BTN_Y=700

ENHANCE_X=350
ENHANCE_Y_3=300
ENHANCE_Y_15=480
ENHANCE_Y_30=660

ENHANCE_WINDOW_X=520
ENHANCE_WINDOW_Y1=240
ENHANCE_WINDOW_Y2=360
ENHANCE_WINDOW_1=0xB08844
ENHANCE_WINDOW_2=0xE1D29D

PURPLE=0xDE5EA0
RED=0xD65733
YELLOW=0xFAD460
BLUE=0x2E9DA4
GREEN=0x25A944

TIANJI_COLOR=0x18637B
TIANJI_X=234
TIANJI_Y=258

XIAOLI_COLOR=0xE0C1A4
XIAOLI_X=234
XIAOLI_Y=258
XIAOLI_HARD_COLOR=0xE2C4A5
XIAOLI_HARD_X=234
XIAOLI_HARD_Y=480

-- HARD
YIHUA_COLOR=0x6B402B
YIHUA_X=234
YIHUA_Y=480

SHANGGUAN_COLOR=0x1D0B02
SHANGGUAN_X=234
SHANGGUAN_Y=258
SHANGGUAN_HARD_COLOR=0x1C0C04
SHANGGUAN_HARD_X=234
SHANGGUAN_HARD_Y=480

-- HARD
SHIWANG_COLOR=0x633832
SHIWANG_X=234
SHIWANG_Y=480

BOUNS_BTN=0XFFFC77
BOUNS_BTN_X=235
BOUNS_BTN_Y=512

BOUNS_BTN_CHECKER=0XD90F09
BOUNS_BTN_CHECKER_X=333
BOUNS_BTN_CHECKER_Y=512

BOUNS_BTN0_X=200
BOUNS_BTN1_Y=100
BOUNS_BTN2_Y=300
BOUNS_BTN3_Y=500
BOUNS_BTN4_Y=700
BOUNS_BTN5_Y=900

CONTINUE_BTN=0x1D8671
CONTINUE_BTN_X=32
CONTINUE_BTN_Y=600

REWARD_BTN=0x208478
REWARD_BTN_X=90
REWARD_BTN_Y=480

SKIP_BTN=0x1A7570
SKIP_BTN_X=32
SKIP_BTN_Y=480

FUWEN_BTN=0X74776B
FUWEN_BTN_X=200
FUWEN_BTN_Y=480

function run()
	mSleep(3000);
	loadSavedStatus();
	while count < 600000 do
		if finished() then
			break;
		end
		if round >= STOP_ROUND then
			break;
		end
		fightEvil();
	end
end

function getBonus()
	mSleep(1000);
	click(BOUNS_BTN0_X, BOUNS_BTN1_Y, 0, 0);
	mSleep(1000);
	click(BOUNS_BTN0_X, BOUNS_BTN2_Y, 0, 0);
	mSleep(1000);
	click(BOUNS_BTN0_X, BOUNS_BTN3_Y, 0, 0);
	mSleep(1000);
	click(BOUNS_BTN0_X, BOUNS_BTN4_Y, 0, 0);
	mSleep(1000);
	click(BOUNS_BTN0_X, BOUNS_BTN5_Y, 0, 0);
end

function gamequit()
	appKill('com.koramgame.dhjhchs');
	appKill('com.ifun.dhjhcht');
end

function finished()
	if clickBtn(FUWEN_BTN, FUWEN_BTN_X, FUWEN_BTN_Y) then
		mSleep(200);
	end
	if findBtn(BOUNS_BTN, BOUNS_BTN_X, BOUNS_BTN_Y) and findBtn(BOUNS_BTN_CHECKER, BOUNS_BTN_CHECKER_X, BOUNS_BTN_CHECKER_Y) then
		clickBtn(BOUNS_BTN, BOUNS_BTN_X, BOUNS_BTN_Y);
		getBonus();
		os.execute("rm " .. PID_NAME);
		if CLOSE_GAME == 1 then
			gamequit();
		end
		logStatus(1);
		logDebug("finished.");
		return true;
	end

	return false;
end

function loadSavedStatus()
	file = io.open(PID_NAME);
	if file ~= nil then
		-- read data from file
		i = 0;
		for line in io.lines(PID_NAME) do
			status[i] = tonumber(line);
			i = i + 1;
		end
		-- the latest round is not save
		-- +1 to revert it
		round = status[5] + 1;
	else
		status[0] = 0;
		status[1] = 0;
		status[2] = 0;
		status[3] = 0;
		status[4] = 0;
		saveStatus();
	end
end

function saveStatus()
	file = io.open(PID_NAME, "w");
	status[5] = round;
	file:write(status[0] .. "\n" .. status[1] .. "\n" .. status[2] .. "\n" .. status[3] .. "\n" .. status[4] .. "\n" .. status[5]);
	file:close();
end

function logStatus(force)
	if debug == 1 or force == 1 then
		logDebug(string.format("P: %s R: %s Y: %s B: %s G: %s on Round: %s saving: %s", status[0], status[1], status[2], status[3], status[4], round, saveStars));
	end
end

function log(s)
	if debug == 1 then
		logDebug(s);
	end
end

function fightEvil()
	count = count + 1;

	click(20, 20, 0, 0);
	mSleep(300);
	clickBtn(SKIP_BTN, SKIP_BTN_X, SKIP_BTN_Y);

	if clickBtn(CONTINUE_BTN, CONTINUE_BTN_X, CONTINUE_BTN_Y) and protecter == 0 then
		round = round + 1;
		protecter = 1;
	end

	clickBtn(REWARD_BTN, REWARD_BTN_X, REWARD_BTN_Y);

	if round <= BLOOD_ROUND then
		clickBloodBtn();
	elseif round <= HARD_ROUND then
		clickHardBtn();
	else
		clickNormalBtn();
	end

	-- enhance window is not open, return
	if findBtn(ENHANCE_WINDOW_1, ENHANCE_WINDOW_X, ENHANCE_WINDOW_Y1) == false or findBtn(ENHANCE_WINDOW_2, ENHANCE_WINDOW_X, ENHANCE_WINDOW_Y2) == false then
		return;
	end

	color3, color15, color30 = findEnhanceColor();

	if round <= STAR_ROUND then
		-- red > purple * 0.7
		if round > 200 and status[0] * PURPLE_RED_RATIO_MAX < status[1] then
			mode = 1;
			if color30 == 'purple' then
				click30(color30);
				status[0] = status[0] + 30;
				return;
			end
			if color15 == 'purple' then
				click15(color15);
				status[0] = status[0] + 15;
				return;
			end
			if color30 == 'red' then
				click30(color30);
				status[1] = status[1] + 30;
				return;
			end
			if color15 == 'red' then
				click15(color15);
				status[1] = status[1] + 15;
				return;
			end
		elseif round > 200 and status[1] < status[0] * PURPLE_RED_RATIO_MIN then
			mode = 2;
			if color30 == 'red' then
				click30(color30);
				status[1] = status[1] + 30;
				return;
			end
			if color15 == 'red' then
				click15(color15);
				status[1] = status[1] + 15;
				return;
			end
			if color30 == 'purple' then
				click30(color30);
				status[0] = status[0] + 30;
				return;
			end
			if color15 == 'purple' then
				click15(color15);
				status[0] = status[0] + 15;
				return;
			end
		else
			mode = 0;
			if color30 == 'purple' then
				click30(color30);
				status[0] = status[0] + 30;
				return;
			end
			if color30 == 'red' then
				click30(color30);
				status[1] = status[1] + 30;
				return;
			end
			if color15 == 'purple' then
				click15(color15);
				status[0] = status[0] + 15;
				return;
			end
			if color15 == 'red' then
				click15(color15);
				status[1] = status[1] + 15;
				return;
			end
		end

		if status[4] < GREEN_MAX and color30 == 'green' then
			click30(color30);
			status[4] = status[4] + 30;
			return;
		end
		if status[3] < BLUE_MAX and color30 == 'blue' then
			click30(color30);
			status[3] = status[3] + 30;
			return;
		end
		if status[2] < YELLOW_MAX and color30 == 'yellow' then
			click30(color30);
			status[2] = status[2] + 30;
			return;
		end
		if status[4] < GREEN_MAX and color15 == 'green' then
			click15(color15);
			status[4] = status[4] + 15;
			return;
		end
		if status[3] < BLUE_MAX and color15 == 'blue' then
			click15(color15);
			status[3] = status[3] + 15;
			return;
		end
		if status[2] < YELLOW_MAX and color15 == 'yellow' then
			click15(color15);
			status[2] = status[2] + 15;
			return;
		end
		
		click3Percent(color3);
		return;
	else
		saveStars = 1;
		click3Percent(color3);
		return;
	end

end

function click30(color)
	click(ENHANCE_X, ENHANCE_Y_30, 0, 0);
	log(color .. ": 30");
end

function click15(color)
	click(ENHANCE_X, ENHANCE_Y_15, 0, 0);
	log(color .. ": 15");
end

function click3(color)
	click(ENHANCE_X, ENHANCE_Y_3, 0, 0);
	log(color .. ": 3");
end

function click3Percent(color)
	click3(color);
	if color == 'purple' then
		status[0] = status[0] + 3;
		return;
	elseif color == 'red' then
		status[1] = status[1] + 3;
		return;
	elseif color == 'yellow' then
		status[2] = status[2] + 3;
		return;
	elseif color == 'blue' then
		status[3] = status[3] + 3;
		return;
	elseif color == 'green' then
		status[4] = status[4] + 3;
		return;
	else
		-- skip
	end
end

function findEnhanceColor()
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_3);
    color3 = getColorHuman(r, g, b);
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_15);
    color15 = getColorHuman(r, g, b);
    r,g,b = getColorRGB(ENHANCE_X, ENHANCE_Y_30);
    color30 = getColorHuman(r, g, b);

	log("find colors: " .. color3 .. " " .. color15 .. " " .. color30);
    
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

    return rgb2Hex(r, g, b);
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

function findBtn(color, x, y)
	local x1, y1, x2, y2;
	x1 = x - REGION_SIZE;
	x2 = x + REGION_SIZE;
	y1 = y - REGION_SIZE;
	y2 = y + REGION_SIZE;

	x, y = findColorInRegionFuzzy(color, FUZZY_NUM, x1, y1, x2, y2);
	if x ~= -1 and y ~= -1 then
		return true;
	end

	return false;
end

function clickBtn(color, x, y)
	if findBtn(color, x, y) then
		click(x, y, 0, 0);
		mSleep(100);
		return true;
	end

	return false;
end

function click(x, y, dx, dy)
    if x ~= -1 and y ~= -1 then
		touchDown(0, (x + dx), (y + dy));
		touchUp(0);
		return true;
    end

    return false;
end

function clickRound(color, x, y)
	if clickBtn(color, x, y) then
		saveStatus();
		protecter = 0;
		logStatus();
    end

    return true;
end

function clickBloodBtn()
	if round > BLOOD_SKIP_ROUND and isInBloodIgnoreList() then
		clickHardBtn();
	else
		clickRound(BLOOD_BTN, BLOOD_BTN_X, BLOOD_BTN_Y);
	end
end

function clickHardBtn()
	local x, y;
	if round > HARD_SKIP_ROUND and isInHardIgnoreList() then
		clickNormalBtn()
	else
		clickRound(HARD_BTN, HARD_BTN_X, HARD_BTN_Y)
	end
end

function clickNormalBtn()
	clickRound(NORMAL_BTN, NORMAL_BTN_X, NORMAL_BTN_Y)
end

function isInBloodIgnoreList()
	-- 天机
	if findBtn(TIANJI_COLOR, TIANJI_X, TIANJI_Y) then
		return true;
	end
	-- 上官
	if findBtn(SHANGGUAN_COLOR, SHANGGUAN_X, SHANGGUAN_Y) then
		return true;
	end
	-- 小李
	if findBtn(XIAOLI_COLOR, XIAOLI_X, XIAOLI_Y) then
		return true;
	end
end

function isInHardIgnoreList()
	-- 移花
	if findBtn(YIHUA_COLOR, YIHUA_X, YIHUA_Y) then
		return true;
	end
	-- 狮王
	if findBtn(SHIWANG_COLOR, SHIWANG_X, SHIWANG_Y) then
		return true;
	end
	-- 小李
	if findBtn(XIAOLI_HARD_COLOR, XIAOLI_HARD_X, XIAOLI_HARD_Y) then
		return true;
	end
	-- 上官
	if findBtn(SHANGGUAN_HARD_COLOR, SHANGGUAN_HARD_X, SHANGGUAN_HARD_Y) then
		return true;
	end
end
