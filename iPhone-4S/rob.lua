temp_route="no_route";
a=1;
npc_route={};
--npc_route[0]="/var/touchelf/clb-cj-p1";
npc_route[1] ="/var/touchelf/scripts/wxqpic/ldnpc/npc01.bmp";
npc_route[2] ="/var/touchelf/scripts/wxqpic/ldnpc/npc02.bmp";
npc_route[3] ="/var/touchelf/scripts/wxqpic/ldnpc/npc03.bmp";
npc_route[4] ="/var/touchelf/scripts/wxqpic/ldnpc/npc04.bmp";
npc_route[5] ="/var/touchelf/scripts/wxqpic/ldnpc/npc05.bmp";
npc_route[6] ="/var/touchelf/scripts/wxqpic/ldnpc/npc06.bmp";
npc_route[7] ="/var/touchelf/scripts/wxqpic/ldnpc/npc07.bmp";
npc_route[8] ="/var/touchelf/scripts/wxqpic/ldnpc/npc11.bmp";
npc_route[9] ="/var/touchelf/scripts/wxqpic/ldnpc/npc12.bmp";
npc_route[10]="/var/touchelf/scripts/wxqpic/ldnpc/npc13.bmp";
npc_route[11]="/var/touchelf/scripts/wxqpic/ldnpc/npc14.bmp";
npc_route[12]="/var/touchelf/scripts/wxqpic/ldnpc/npc15.bmp";

-- 主入口函数
function main()
    mSleep(1000);
	count=0;
	while count < 3000 do
	heartBeat();
    keepScreen(true);
	--主界面掠夺
	clickBtn(  87,632 , 0xE0984E);
	--跳过
	clickBtn(  41,512 , 0xD4C773);
	--继续
	clickBtn(  35,615 , 0x495B55);
	--再来一次
	clickBtn(  213,645, 0xDED4AA);
	--得到残片后返回
	clickBtn(  207,470, 0x494B5A);
	--拼合残片
	clickBtn(  283,741, 0x1F8778);
	--接受拼合残片
	clickBtn(   96,508, 0xD6C172);
	--接受拼合残片--紫片
	clickBtn(   98,503, 0xEED577);
	--接受拼合残片--绿片
	clickBtn(   98,503, 0x7C815E);
	--找残片
	clickBtn(    454,425 , 0x3C5A61);
	clickBtn(    320,425 , 0x406064);
	clickBtn(    320,147 , 0x486873);
	clickBtn(    454,147 , 0x45656E);
	clickBtn(    522,286 , 0x395860);
	clickBtn(    259,285 , 0x4F6F7D);

	--提示找NPC	start
	--nx1, ny1 = findColorInRegion(0x39504D,48,735,48,735);
	--nx2, ny2 = findColorInRegion(0x5C6E65,48,748,48,748);
	--if nx1 ~= -1 and ny1 ~= -1 and nx2 ~= -1 and ny2 ~= -1
	--then
	----notifyVibrate(3000);
	----notifyVoice('/var/touchelf/music/shortmp3.mp3');
	--mSleep(300);
	--end;
	--提示找NPC end

	a=1;
	npc_x=-1;
	npc_y=-1;
	--自动找NPC
	while a<13 and npc_x==-1 and npc_y==-1 do
		a=a+1;
	    npc_x, npc_y=findImageInRegionFuzzy(npc_route[a],75,519,502,558,703);
        if 	npc_x ~=-1 and  npc_y ~=-1
		then
	    a=999;
		--点击掠夺NPC
		click( 132,606,0,0);
	    end

	end
	--自动找NPC
    --snapshotRegion(string.format("/var/touchelf/wxqpic/ldnpc/new_ldnpc_%s.bmp",os.time()),519,502,558,703);

	--loading界面休息几秒
	lx1, ly1 = findColorInRegion(0x39504D, 588,502 , 588,502 );
	lx2, ly2 = findColorInRegion(0x5C422B, 589,502 , 589,502 );
	lx3, ly3 = findColorInRegion(0x040100, 590,502 , 590,502 );
	lx4, ly4 = findColorInRegion(0x000000, 591,502 , 591,502 );
    if lx1 ~= -1 and lx2 ~= -1 and lx3 ~= -1 and lx4 ~= -1
	then
	mSleep(5000);
	end;
	--do calc
    count=count+1;
	mSleep(300);

	--找不到就换一批
	clickBtn(  62,508 , 0x549690);

    --掠夺界面 元气不足s
	yq_x1, yq_y1 = findColorInRegion(0xE5E28E, 439,551 , 439,551 );
	yq_x2, yq_y2 = findColorInRegion(0x383F30, 439,553 , 439,553 );
	yq_x3, yq_y3 = findColorInRegion(0x163844, 439,555 , 439,555 );
    if yq_x1 ~= -1 and yq_y1 ~= -1 and yq_x2 ~= -1 and yq_y2 ~= -1 and yq_x3 ~= -1 and yq_y3 ~= -1
	then
	count=count+9999;
	end;
	--掠夺界面 元气不足e

	keepScreen(false);
	end

   -- keyDown('HOME');  -- HOME键按下
   --mSleep(500);
   -- keyUp('HOME');    -- HOME键抬起

	notifyMessage('work done!');
	mSleep(1000);
	gamequit();

end

function gamequit()
	appKill('com.koramgame.dhjhchs');
end

function clickBtn(x, y, hex)
	x, y = findColorInRegion(hex, x, y, x, y);
	if x ~= -1 and y ~= -1 then
		click(x, y, 0, 0)
	end
end

function click(x,y,dx,dy)
    if x ~= -1 and y ~= -1 then
        touchDown(0, (x+dx), (y+dy))   ;
        touchUp(0);
    end
end

function heartBeat()
	touchDown(0,320,2)
    touchUp(0);
	mSleep(300);
end