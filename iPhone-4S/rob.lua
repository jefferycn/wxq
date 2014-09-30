-- SCREEN_RESOLUTION="640x960"
-- SCREEN_COLOR_BITS=32

AUTO_QUIT=0;

REGION_SIZE=3;
FUZZY_NUM=98;

npc_pic={};
npc_pic[1] = "/var/touchelf/scripts/pic/y1.bmp";
npc_pic[2] = "/var/touchelf/scripts/pic/y2.bmp";
npc_pic[3] = "/var/touchelf/scripts/pic/y3.bmp";
npc_pic[4] = "/var/touchelf/scripts/pic/y4.bmp";
npc_pic[5] = "/var/touchelf/scripts/pic/h1.bmp";
npc_pic[6] = "/var/touchelf/scripts/pic/h2.bmp";
npc_pic[7] = "/var/touchelf/scripts/pic/h3.bmp";
npc_pic[8] = "/var/touchelf/scripts/pic/h4.bmp";

npc_route={};
npc_route[1] = 70;
npc_route[2] = 310;
npc_route[3] = 550;
npc_route[4] = 790;
npc_route[5] = 70;
npc_route[6] = 310;
npc_route[7] = 550;
npc_route[8] = 790;

function main()
    mSleep(1000);
	count=0;
	while count < 3000 do
		heartBeat();
	    keepScreen(true);

		--主界面掠夺
		clickBtn(0xE0984E, 87, 632);
		--跳过
		clickBtn(0xD4C773, 41, 512);
		--继续
		clickBtn(0x495B55, 35, 615);
		--再来一次
		clickBtn(0xDED4AA, 213, 645);
		--得到残片后返回
		clickBtn(0x494B5A, 207, 470);
		--拼合残片
		clickBtn(0x1F8778, 283, 741);
		--接受拼合残片
		clickBtn(0xD6C172, 96, 508);
		--接受拼合残片--紫片
		clickBtn(0xEED577, 98, 503);
		--接受拼合残片--绿片
		clickBtn(0x7C815E, 98, 503);
		--找残片
		clickBtn(0x3C5A61, 454, 425);
		clickBtn(0x406064, 320, 425);
		clickBtn(0x486873, 320, 147);
		clickBtn(0x45656E, 454, 147);
		clickBtn(0x395860, 522, 286);
		clickBtn(0x4F6F7D, 259, 285);

		i=0;
		npc_x=-1;
		npc_y=-1;
		
		--自动找NPC
		while i<8 and npc_x==-1 and npc_y==-1 do
			i=i+1;
			local y1, y2;
			y1 = npc_route[i];
			y2 = y1 + 40;
			-- x1: 528 x2: 548
		    npc_x, npc_y=findImageInRegionFuzzy("" .. npc_pic[i], 70, 528, y1, 548, y2);
	        if 	npc_x ~=-1 and npc_y ~=-1 then
				--点击掠夺NPC
				click(npc_x, npc_y, -400, 40);
				break;
		    end
		end

		count=count+1;
		mSleep(300);

		--找不到就换一批
		clickBtn(0x549690, 62, 508);

		keepScreen(false);
	end

	mSleep(1000);
	gamequit();
end

function gamequit()
	if AUTO_QUIT then
		appKill('com.koramgame.dhjhchs');
	end
end

function heartBeat()
	touchDown(0,320,2)
    touchUp(0);
	mSleep(300);
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
