
-- 适用屏幕参数
SCREEN_RESOLUTION="640x960";
SCREEN_COLOR_BITS=32;

count=1;
round=1;
bloodRound=150;
bloodSkipRound=130;
hardRound=200;
hardSkipRound=160;
starRound=300;
stopRound=9999;
-- purple,red,green
status={};
pidName="/var/touchelf/a3.pid";
saveStars=0;
-- 0 default, 1 blood first, 2 force first
mode=0;
prevX=-1;
prevY=-1;
x_30=350;
y_30=670;
x_15=350;
y_15=470;
x_3=350;
y_3=350;
clicked=0;

function main()
	loadSavedStatus();
	while count<600000 do
		clicked=0;
		fightEvil();
		mSleep(500);
		if round >= stopRound then
			break;
		end
		if deletestatus() then
			logDebug("finished.");
			break;
		end
	end
end

function deletestatus()
	-- 0
	x, y =findColorInRegion(0xfff4bb,239,333,239,333);
	-- 2
	x2, y2 =findColorInRegion(0xeccb62,236,876,236,876);
	-- 1
	x1, y1 =findColorInRegion(0xf3c759,235,867,235,867);
	if (x ~= -1 and y ~= -1) or (x2 ~= -1 and y2 ~= -1) or (x1 ~= -1 and y1 ~= -1) then
		os.execute("rm " .. pidName);
		return true;
	end

	return false;
end

function loadSavedStatus()
	file = io.open(pidName);
	if file ~= nil then
		-- read data from file
		i = 0;
		for line in io.lines(pidName) do
			status[i] = tonumber(line);
			i = i + 1;
		end
		-- the latest round is not save
		-- +1 to revert it
		round = status[3] + 1;
	else
		status[0] = 0;
		status[1] = 0;
		status[2] = 0;
		saveStatus();
	end
end

function saveStatus()
	file = io.open(pidName, "w");
	status[3] = round;
	file:write(status[0] .. "\n" .. status[1] .. "\n" .. status[2] .. "\n" .. status[3]);
	file:close();
end

function logStatus()
	logDebug(string.format("P: %s R: %s G: %s on Round: %s mode: %s saving: %s", status[0], status[1], status[2], round, mode, saveStars));
end

function fightEvil()
	count=count+1;

	--判斷跳過動畫
	x, y =findColorInRegion(0x1f907d,35,481,35,481);
	click(x,y,20,20)
	touchDown(0, 600, 570)
    touchUp(0);
	mSleep(300);
   	x, y =findColorInRegion(0x1f907d,35,481,35,481);
	click(x,y,20,20)
    --touchDown(0, 600, 570)
    --touchUp(0);

	--打完繼續
	x1, y1 =findColorInRegion(0x21937d,29,587,29,587);
	click(x1,y1,0,0)

	--領獎勵
	x2, y2 =findColorInRegion(0x1f937a,95,482,95,482);
	click(x2,y2,0,0)

	if round<=bloodRound then
		clickBloodBtn();
	elseif round<= hardRound then
		clickHardBtn();
	else
		clickNormalBtn();
	end

	if round<=starRound then
		r,g,b = getColorRGB(x_30,y_30);
		r1,g1,b1 = getColorRGB(x_15,y_15);

		-- red > purple * 0.7
		if status[1] > 200 and status[0] * 0.7 < status[1] then
			mode = 1;
			click30purple(r,g,b);
			click15purple(r1,g1,b1);
			click30red(r,g,b);
			click30green(r,g,b);
			click15red(r1,g1,b1);
			click15green(r1,g1,b1);
			click3Percent();
		elseif status[0] > 200 and status[1] < status[0] * 0.6 then
			mode = 2;
			click30red(r,g,b);
			click15red(r1,g1,b1);
			click30purple(r,g,b);
			click30green(r,g,b);
			click15purple(r1,g1,b1);
			click15green(r1,g1,b1);
			click3Percent();
		else
			mode = 0;
			click30purple(r,g,b);
			click30red(r,g,b);
			click30green(r,g,b);
			click15purple(r1,g1,b1);
			click15red(r1,g1,b1);
			click15green(r1,g1,b1);
			click3Percent();
		end
	else
		saveStars = 1;
		click3Percent();
	end
end

function clickRound(x,y,dx,dy)

	if clicked == 1 then
		return false;
	end

	if x ~= -1 and y ~= -1 and prevX == -1 and prevY == -1 then
		clicked=1;
		prevX = 1;
		prevY = 1;
		saveStatus();
		logStatus();
		round=round+1;
		touchDown(0, (x+dx), (y+dy)) ;
		touchUp(0);
    elseif x == -1 and y == -1 and prevX == 1 and prevY == 1 then
    	prevX = -1;
    	prevY = -1;
    	mSleep(3000);
    else
    	-- skip
    end

    return true;
end

function click3Percent()
	if clicked == 1 then
		return false;
	end

	local r,g,b;
	r,g,b = getColorRGB(x_3,y_3);

	if r == 57 and g == 143 and b == 146 then
		-- 3% 内力
		click(x_3,y_3,0,0);
	elseif r == 203 and g == 94 and b == 147 then
		-- 3% 气血
		click(x_3,y_3,0,0);
		status[0] = status[0] + 3;
	elseif r == 193 and g == 82 and b == 58 then
		-- 3% 武力
		click(x_3,y_3,0,0);
		status[1] = status[1] + 3;
	elseif r == 235 and g == 193 and b == 94 then
		-- 3% 防御
		click(x_3,y_3,0,0);
	elseif r == 65 and g == 159 and b == 79 then
		-- 3% 身法
		click(x_3,y_3,0,0);
		status[2] = status[2] + 3;
	else
		-- skip
	end
end

function click(x,y,dx,dy)
	if clicked == 1 then
		return false;
	end

    if x ~= -1 and y ~= -1 then
        touchDown(0, (x+dx), (y+dy));
        touchUp(0);
        clicked=1;
    end

    return true;
end

function clickBloodBtn()
	local x, y;
	if round > bloodSkipRound and isInBloodIgnoreList() then
		clickHardBtn();
	else
		x, y =findColorInRegion(0x9f3637,143,250,143,250);
		clickRound(x,y,0,0)
	end
end

function clickHardBtn()
	local x, y;
	if round > hardSkipRound and isInHardIgnoreList() then
		clickNormalBtn()
	else
		x, y =findColorInRegion(0xd2bb74,143,465,143,465);
		clickRound(x,y,0,0)
	end
end

function clickNormalBtn()
	local x, y;
	x, y =findColorInRegion(0x74575b,143,685,143,685);
	clickRound(x,y,0,0)
end

function isInBloodIgnoreList()
	-- 天机
	x, y =findColorInRegion(0x3d3a34,266,261,266,261);
	if x ~= -1 and y ~= -1 then
		return true;
	end
	-- 上官
	x, y =findColorInRegion(0xb68d31,254,279,254,279);
	if x ~= -1 and y ~= -1 then
		return true;
	end
	-- 小李
	x, y =findColorInRegion(0x4b3b32,263,267,263,267);
	if x ~= -1 and y ~= -1 then
		return true;
	end
end

function isInHardIgnoreList()
	-- 移花
	x, y =findColorInRegion(0x7a2476,334,478,334,478);
	if x ~= -1 and y ~= -1 then
		return true;
	end
	-- 狮王
	x, y =findColorInRegion(0x310e10,270,491,270,491);
	if x ~= -1 and y ~= -1 then
		return true;
	end
	-- 小李
	x, y =findColorInRegion(0xe8ceac,266,476,266,476);
	if x ~= -1 and y ~= -1 then
		return true;
	end
	-- 上官
	x, y =findColorInRegion(0x926c28,254,492,254,492);
	if x ~= -1 and y ~= -1 then
		return true;
	end
end

function click30purple(r, g, b)
	if r == 220 and g == 95 and b == 161 then
		local x;
		x = click(x_30,y_30,0,0);
		if x then
			status[0] = status[0] + 30;
		end
		return x;
	end

	return false;
end

function click30red(r, g, b)
	if r == 215 and g == 91 and b == 58 then
		local x;
		x = click(x_30,y_30,0,0);
		if x then
			status[1] = status[1] + 30;
		end
		return x;
	end

	return false;
end

function click30green(r, g, b)
	if r == 37 and g == 171 and b == 70 then
		local x;
		x = click(x_30,y_30,0,0);
		if x then
			status[2] = status[2] + 30;
		end
		return x;
	end

	return false;
end

function click15purple(r, g, b)
	if r == 222 and g == 95 and b == 161 then
		local x;
		x = click(x_15,y_15,0,0);
		if x then
			status[0] = status[0] + 15;
		end
		return x;
	end

	return false;
end

function click15red(r, g, b)
	if r == 211 and g == 87 and b == 49 then
		local x;
		x = click(x_15,y_15,0,0);
		if x then
			status[1] = status[1] + 15;
		end
		return x;
	end

	return false;
end

function click15green(r, g, b)
	if r == 34 and g == 171 and b == 68 then
		local x;
		x = click(x_15,y_15,0,0);
		if x then
			status[2] = status[2] + 15;
		end
		return x;
	end

	return false;
end
