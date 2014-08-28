SCREEN_RESOLUTION="640x960"
SCREEN_COLOR_BITS=32

count=1
round=1
saveStars=0
protecter=0
-- 0 default, 1 blood first, 2 force first
mode=0

REGION_SIZE=3;

-- purple,red,yellow,blue,green
status={};

FUZZY_NUM=97

BLOOD_BTN=0xCD5844
BLOOD_BTN_X=130
BLOOD_BTN_Y=260
HARD_BTN=0xD5583C
HARD_BTN_X=130
HARD_BTN_Y=480
NORMAL_BTN=0xD15645
NORMAL_BTN_X=130
NORMAL_BTN_Y=700

ENHANCE_X=350
ENHANCE_Y_3=300
ENHANCE_Y_15=480
ENHANCE_Y_30=660

PURPLE_3=0xDE5FA1
PURPLE_15=0xDD5FA1
PURPLE_30=0xDE5FA1
RED_3=0xD55532
RED_15=0xD65734
RED_30=0xD65735
YELLOW_3=0xFAD65F
YELLOW_15=0xF9D65E
YELLOW_30=0xFAD65F
BLUE_3=0x2A9DA1
BLUE_15=0x2A9EA1
BLUE_30=0x2A9CA1
GREEN_3=0x2DAC4C
GREEN_15=0x26AB46
GREEN_30=0x2DAC4C

TIANJI_COLOR=0x1B6581
TIANJI_X=234
TIANJI_Y=258

XIAOLI_COLOR=0xE4C5A0
XIAOLI_X=234
XIAOLI_Y=258
XIAOLI_HARD_COLOR=0xE9C8A4
XIAOLI_HARD_X=234
XIAOLI_HARD_Y=480

YIHUA_COLOR=0x5A3828
YIHUA_X=234
YIHUA_Y=480

SHANGGUAN_COLOR=0x190B00
SHANGGUAN_X=234
SHANGGUAN_Y=258
SHANGGUAN_HARD_COLOR=0x1A0A01
SHANGGUAN_HARD_X=234
SHANGGUAN_HARD_Y=480

SHIWANG_COLOR=0x66322F
SHIWANG_X=234
SHIWANG_Y=480

BOUNS_BTN=0xFFFD77
BOUNS_BTN_X=235
BOUNS_BTN_Y=512

BOUNS_BTN0_X=200
BOUNS_BTN1_Y=100
BOUNS_BTN2_Y=300
BOUNS_BTN3_Y=500
BOUNS_BTN4_Y=700
BOUNS_BTN5_Y=900

CONTINUE_BTN=0x1D8671
CONTINUE_BTN_X=32
CONTINUE_BTN_Y=600

REWARD_BTN=0x2F474D
REWARD_BTN_X=100
REWARD_BTN_Y=480

SKIP_BTN=0x1A7570
SKIP_BTN_X=32
SKIP_BTN_Y=480

FUWEN_BTN=0XF0DD9D
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
	keepScreen(true);
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
end

function finished()
	if clickBtn(FUWEN_BTN, FUWEN_BTN_X, FUWEN_BTN_Y) then
		mSleep(200);
	end
	if clickBtn(BOUNS_BTN, BOUNS_BTN_X, BOUNS_BTN_Y) then
		getBonus();
		os.execute("rm " .. PID_NAME);
		if CLOSE_GAME == 1 then
			gamequit();
		end
		logStatus();
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

function logStatus()
	logDebug(string.format("P: %s R: %s Y: %s B: %s G: %s on Round: %s saving: %s", status[0], status[1], status[2], status[3], status[4], round, saveStars));
end

function fightEvil()
	keepScreen(false);
	count = count + 1;

	click(20, 20, 0, 0);
	mSleep(100);
	clickBtn(SKIP_BTN, SKIP_BTN_X, SKIP_BTN_Y);

	if clickBtn(CONTINUE_BTN, CONTINUE_BTN_X, CONTINUE_BTN_Y) and protecter == 0 then
		round = round + 1;
		protecter = 1;
		mSleep(300);
	end

	clickBtn(REWARD_BTN, REWARD_BTN_X, REWARD_BTN_Y);

	if round <= BLOOD_ROUND then
		clickBloodBtn();
	elseif round <= HARD_ROUND then
		clickHardBtn();
	else
		clickNormalBtn();
	end

	keepScreen(true);
	if round <= STAR_ROUND then
		-- red > purple * 0.7
		if round > 200 and status[0] * PURPLE_RED_RATIO_MAX < status[1] then
			mode = 1;
			if click30purple() then
				return;
			end
			if click15purple() then
				return;
			end
			if click30red() then
				return;
			end
			if click15red() then
				return;
			end
		elseif round > 200 and status[1] < status[0] * PURPLE_RED_RATIO_MIN then
			mode = 2;
			if click30red() then
				return;
			end
			if click15red() then
				return;
			end
			if click30purple() then
				return;
			end
			if click15purple() then
				return;
			end
		else
			mode = 0;
			if click30purple() then
				return;
			end
			if click30red() then
				return;
			end
			if click15purple() then
				return;
			end
			if click15red() then
				return;
			end
		end
		
		if click30green() then
			return;
		end
		if click30blue() then
			return;
		end
		if click30yellow() then
			return;
		end
		if click15green() then
			return;
		end
		if click15blue() then
			return;
		end
		if click15yellow() then
			return;
		end
		if click3Percent() then
			return;
		end
	else
		saveStars = 1;
		if click3Percent() then
			return;
		end
	end

	keepScreen(false);
end

function click3Percent()
	if clickBtn(PURPLE_3, ENHANCE_X, ENHANCE_Y_3) then
		-- 3% 气血
		status[0] = status[0] + 3;
	elseif clickBtn(RED_3, ENHANCE_X, ENHANCE_Y_3) then
		-- 3% 武力
		status[1] = status[1] + 3;
	elseif clickBtn(YELLOW_3, ENHANCE_X, ENHANCE_Y_3) then
		-- 3% 防御
		status[2] = status[2] + 3;
	elseif clickBtn(BLUE_3, ENHANCE_X, ENHANCE_Y_3) then
		-- 3% 内力
		status[3] = status[3] + 3;
	elseif clickBtn(GREEN_3, ENHANCE_X, ENHANCE_Y_3) then
		-- 3% 身法
		status[4] = status[4] + 3;
	else
		-- skip
	end
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
    end

    return true;
end

function clickRound(color, x, y)
	if clickBtn(color, x, y) then
		saveStatus();
		protecter = 0;
		-- logStatus();
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

function click30purple()
	if clickBtn(PURPLE_30, ENHANCE_X, ENHANCE_Y_30) then
		status[0] = status[0] + 30;
		return true;
	end

	keepScreen(false);

	return false;
end

function click30red()
	if clickBtn(RED_30, ENHANCE_X, ENHANCE_Y_30) then
		status[1] = status[1] + 30;
		return true;
	end

	keepScreen(false);

	return false;
end

function click30yellow()
	if status[2] < YELLOW_MAX and clickBtn(YELLOW_30, ENHANCE_X, ENHANCE_Y_30) then
		status[2] = status[2] + 30;
		return true;
	end

	keepScreen(false);

	return false;
end

function click30blue()
	if status[3] < BLUE_MAX and clickBtn(BLUE_30, ENHANCE_X, ENHANCE_Y_30) then
		status[3] = status[3] + 30;
		return true;
	end

	keepScreen(false);

	return false;
end

function click30green()
	if status[4] < GREEN_MAX and clickBtn(GREEN_30, ENHANCE_X, ENHANCE_Y_30) then
		status[4] = status[4] + 30;
		return true;
	end

	keepScreen(false);

	return false;
end

function click15purple()
	if clickBtn(PURPLE_15, ENHANCE_X, ENHANCE_Y_15) then
		status[0] = status[0] + 15;
		return true;
	end

	keepScreen(false);

	return false;
end

function click15red()
	if clickBtn(RED_15, ENHANCE_X, ENHANCE_Y_15) then
		status[1] = status[1] + 15;
		return true;
	end

	keepScreen(false);

	return false;
end

function click15yellow()
	if status[2] < YELLOW_MAX and clickBtn(YELLOW_15, ENHANCE_X, ENHANCE_Y_15) then
		status[2] = status[2] + 15;
		return true;
	end

	keepScreen(false);

	return false;
end

function click15blue()
	if status[3] < BLUE_MAX and clickBtn(BLUE_15, ENHANCE_X, ENHANCE_Y_15) then
		status[3] = status[3] + 15;
		return true;
	end

	keepScreen(false);

	return false;
end

function click15green()
	if status[4] < GREEN_MAX and clickBtn(GREEN_15, ENHANCE_X, ENHANCE_Y_15) then
		status[4] = status[4] + 15;
		return true;
	end

	keepScreen(false);

	return false;
end

function click3purple()
	if clickBtn(PURPLE_3, ENHANCE_X, ENHANCE_Y_3) then
		status[0] = status[0] + 3;
		return true;
	end

	keepScreen(false);

	return false;
end

function click3red()
	if clickBtn(RED_3, ENHANCE_X, ENHANCE_Y_3) then
		status[1] = status[1] + 3;
		return true;
	end

	keepScreen(false);

	return false;
end

function click3yellow()
	if clickBtn(YELLOW_3, ENHANCE_X, ENHANCE_Y_3) then
		status[2] = status[2] + 3;
		return true;
	end

	keepScreen(false);

	return false;
end

function click3blue()
	if clickBtn(BLUE_3, ENHANCE_X, ENHANCE_Y_3) then
		status[3] = status[3] + 3;
		return true;
	end

	keepScreen(false);

	return false;
end

function click3green()
	if clickBtn(GREEN_3, ENHANCE_X, ENHANCE_Y_3) then
		status[4] = status[4] + 3;
		return true;
	end

	keepScreen(false);

	return false;
end
