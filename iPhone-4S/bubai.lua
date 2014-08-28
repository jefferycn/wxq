
-- 适用屏幕参数
SCREEN_RESOLUTION="640x960";
SCREEN_COLOR_BITS=32;

count=1;

--在keepScreen(true)和keepScreen(false)之间屏幕图片内容在内存中保持不变

-- 各个按钮位置:欲火重生按钮   152,876 0x84CFD8
-- 各个按钮位置:欲火重生按钮    50,876 0x1BB5F3

-- 各个按钮位置:挑战    按钮  152,876 0xD39B89 2014-06-24 变为：0xD3A088
-- 各个按钮位置:挑战    按钮   50,876 0xF88322

-- 各个按钮位置:战斗中  按钮上灰   50,399  0x4B4B4B
-- 各个按钮位置:战斗中  按钮 米黄字 50,501  0xEFDD8B
-- 各个按钮位置:战斗中  按钮下灰   50,520  0x666666
-- 各个按钮位置:战斗中 辅助判断地板颜色

-- 结束画面，xx已被击杀
-- 结束画面  172,111  0x2E7DE1 蓝色声望
-- 结束画面  292,111  0xB131C2 紫色元神
-- 结束画面   605,491   0xFEFEFE 已
-- 结束画面   605,530   0xB0B0B3 被
-- 结束画面   605,554   0xB7B7B7 击
-- 结束画面   605,588   0xA2A1A1 杀

-- 继续画面    36,579 0x17464A 继续之下
-- 继续画面    49,579 0xF0E8A4 继续之中
-- 继续画面    68,579 0x519490 继续之上

function main()

   	while count < 1200 do
		heartBeat();	
	keepScreen(true);
	--挑战
		skipBtn(  152,876 ,0xD39B89);
		skipBtn(  152,876 ,0xD3A088);
	--继续		
		skipBtn(   68,579,0x519490);		
		count = count + 1;
	--判断是否结束。
	if bubaiover() then
	--	notifyMessage("终于点完球了");	
	notifyMessage(string.format("终于点完球了%s P:%s,%s",count,x3,y3));		
	end;	
	keepScreen(false);
	mSleep(1000);
	end
	--结束提示
	--notifyVoice('/var/touchelf/music/noticemp3.mp3')
	notifyVibrate(3000)
    notifyMessage("~~打完了~~")
	mSleep(80000);
end

function heartBeat()
	touchDown(0,100,479)
    touchUp(0);
	mSleep(300);
end	

-- 结束画面，xx已被击杀
-- 结束画面  172,111  0x2E7DE1 蓝色声望
-- 结束画面  292,111  0xB131C2 紫色元神
-- 结束画面   605,491   0xFEFEFE 已
-- 结束画面   605,491   0xB0B0B3 被
-- 结束画面   605,554   0xB7B7B7 击
-- 结束画面   605,588   0xA2A1A1 杀

function bubaiover()
	--找紫边  307,111  0xB131C6  322,111 
	x1, y1 = findColorInRegion(0xB131C6, 307,111,307,111);
	x2, y2 = findColorInRegion(0xB131C6, 322,111,322,111);
	--找蓝边 	
	x3, y3 = findColorInRegion(0x2E7DE1, 172,111,172,111);
			
	if   x1 ~= -1 and y1 ~= -1 and x2 ~= -1 and y2 ~= -1 
	and  x3 ~= -1 and y3 ~= -1	then
		count = count + 1200;
		return true;
				
	end
	return false;
		
end

function skipBtn(x, y, hex)
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

