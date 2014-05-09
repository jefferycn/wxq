
-- 适用屏幕参数
SCREEN_RESOLUTION="640x960";
SCREEN_COLOR_BITS=32;

count=1;
round=1;
bloodRound=255;
hardRound=366;
starRound=999;
stopRound=9999;
-- purple,green,red
status={};
pidName="/var/touchelf/yang.pid";
saveStars=0;
-- 0 default, 1 blood first, 2 force first
mode=0;

function main()
	loadSavedStatus();
	while count<600000 do
		keepScreen(false);
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
	keepScreen(false);
	x, y =findColorInRegion(0xfff4bb,239,333,239,333);
	keepScreen(true);
	-- 2
	x2, y2 =findColorInRegion(0xfffcab,234,324,234,324);
	-- 1
	x1, y1 =findColorInRegion(0xff7631,205,329,205,329);
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
		round = status[3];
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

    keepScreen(true);

	--打完繼續
	x1, y1 =findColorInRegion(0x21937d,29,587,29,587);
	click(x1,y1,0,0)

	--領獎勵
	x2, y2 =findColorInRegion(0x1f937a,95,482,95,482);
	click(x2,y2,0,0)

	if round<=bloodRound then
		--血戰
		x3, y3 =findColorInRegion(0x9f3637,143,250,143,250);
		clickRound(x3,y3,0,0)
	elseif round<= hardRound then
		--力戰
		x4, y4 =findColorInRegion(0xd2bb74,143,465,143,465);
		clickRound(x4,y4,0,0)
	else
		--奮戰
		x5, y5 =findColorInRegion(0x74575b,143,685,143,685);
		clickRound(x5,y5,0,0)
	end

	if round<=starRound then
	    --點加成
		--30%氣血
		x6, y6 =findColorInRegion(0xdc5fa1,350,670,350,670);

		--30%武力
		x7, y7 =findColorInRegion(0xd75b3a,350,670,350,670);

		--30%防禦
		-- x8, y8 =findColorInRegion(0xfcd466,350,670,350,670);

		--30%身法
		x9, y9 =findColorInRegion(0x25ab46,350,670,350,670);

		--15%氣血
		x10, y10 =findColorInRegion(0xde5fa1,350,470,360,480);

		--15%武力
		x11, y11 =findColorInRegion(0xd35731,350,470,360,480);

		--15%防禦
		-- x12, y12 =findColorInRegion(0xf7d360,350,470,360,480);

		--15%身法
		x13, y13 =findColorInRegion(0x22ab44,350,470,360,480);

		--3%氣血
		-- x14, y14 =findColorInRegion(0xcb5e93,350,350,360,360);

		--3%武力
		-- x15, y15 =findColorInRegion(0xc1523a,350,350,360,360);

		--3%防禦
		-- x16, y16 =findColorInRegion(0xebc15e,350,350,360,360);

		--3%身法
		x17, y17 =findColorInRegion(0x419f4f,350,350,360,360);

		-- red > purple * 0.7
		if status[1] > 200 and status[0] * 0.7 < status[1] then
			mode = 1;
			-- then purple 15 first
			if x6 ~= -1 then
				-- 气血 30
				status[0] = status[0] + 30;
				click(x6,y6,0,0)
			elseif x10 ~= -1 then
				-- 气血 15
				status[0] = status[0] + 15;
				click(x10,y10,0,0)
			elseif x7 ~= -1 then
				-- 武力 30
				status[1] = status[1] + 30;
				click(x7,y7,0,0)
			elseif x9 ~= -1 then
				-- 身法 30
				status[2] = status[2] + 30;
				click(x9,y9,0,0)
			elseif x11 ~= -1 then
				-- 武力 15
				status[1] = status[1] + 15;
				click(x11,y11,0,0)
			elseif x13 ~= -1 then
				-- 身法 15
				status[2] = status[2] + 15;
				click(x13,y13,0,0)
			else
				-- 3%
				click3Percent();
			end
		elseif status[0] > 200 and status[1] < status[0] * 0.6 then
			mode = 2;
			-- then red 15 first
			if x7 ~= -1 then
				-- 武力 30
				status[1] = status[1] + 30;
				click(x7,y7,0,0)
			elseif x11 ~= -1 then
				-- 武力 15
				status[1] = status[1] + 15;
				click(x11,y11,0,0)
			elseif x6 ~= -1 then
				-- 气血 30
				status[0] = status[0] + 30;
				click(x6,y6,0,0)
			elseif x9 ~= -1 then
				-- 身法 30
				status[2] = status[2] + 30;
				click(x9,y9,0,0)
			elseif x10 ~= -1 then
				-- 气血 15
				status[0] = status[0] + 15;
				click(x10,y10,0,0)
			elseif x13 ~= -1 then
				-- 身法 15
				status[2] = status[2] + 15;
				click(x13,y13,0,0)
			else
				-- 3%
				click3Percent();
			end
		else
			mode = 0;
			if x6 ~= -1 then
				-- 气血 30
				status[0] = status[0] + 30;
				click(x6,y6,0,0)
			elseif x7 ~= -1 then
				-- 武力 30
				status[1] = status[1] + 30;
				click(x7,y7,0,0)
			elseif x9 ~= -1 then
				-- 身法 30
				status[2] = status[2] + 30;
				click(x9,y9,0,0)
			elseif x11 ~= -1 then
				-- 武力 15
				status[1] = status[1] + 15;
				click(x11,y11,0,0)
			elseif x10 ~= -1 then
				-- 气血 15
				status[0] = status[0] + 15;
				click(x10,y10,0,0)
			elseif x13 ~= -1 then
				-- 身法 15
				status[2] = status[2] + 15;
				click(x13,y13,0,0)
			else
				-- 3%
				click3Percent();
			end
		end
	else
		saveStars = 1;
		click3Percent();
	end
end

function clickRound(x,y,dx,dy)

	if x ~= -1 and y ~= -1 then
		saveStatus();
		logStatus();
		round=round+1;
		touchDown(0, (x+dx), (y+dy)) ;
		touchUp(0);
		mSleep(5000);
    end

end

function click3Percent()
	click(350,350,0,0);
end

function click(x,y,dx,dy)
    if x ~= -1 and y ~= -1 then
        touchDown(0, (x+dx), (y+dy))   ;
        touchUp(0);
        --mSleep(500);
    end

end

