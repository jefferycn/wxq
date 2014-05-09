
-- 适用屏幕参数
SCREEN_RESOLUTION="640x960";
SCREEN_COLOR_BITS=32;


count=1;
function main()

   	while count<6000 do
		scramble();
		mSleep(300);
	end


end

function scramble()
	count=count+1;

	--判斷跳過動畫
	x, y =findColorInRegion(0x1f907d,35,481,35,481);
	click(x,y,20,20)
	touchDown(0,540, 570)
    touchUp(0);
	mSleep(300);
   	x, y =findColorInRegion(0x1f907d,35,481,35,481);
	click(x,y,20,20)

    --touchDown(0, 540, 570)
    --touchUp(0);

	--開啟螢幕保持,find color及find image不重抓圖來判斷,加速效能
	--keepScreen(true);

    --找殘片
	x1, y1 =findColorInRegion(0x193c44,265,86,265,86);
	click(x1, y1,0,0)

	x2, y2 =findColorInRegion(0x193644,401,86,401,86);
	click(x2,y2,0,0)

	x3, y3 =findColorInRegion(0x1e3746,269,364,269,364);
	click(x3,y3,0,0)

	x4, y4 =findColorInRegion(0x1a3a44,401,363,401,363);
	click(x4,y4,0,0)

	x5, y5 =findColorInRegion(0x193c4a,471,228,471,228);
	click(x5,y5,0,0)

	x16, y16 =findColorInRegion(0x224455,260,256,260,256);
	click(x16,y16,0,0)




	--找NPC名字
	x7, y7 =findImageInRegionFuzzy("/var/touchelf/scripts/bmp/npc1.bmp",70,528,70,550,110);
	--x7, y7 =findImageInRegion("/var/touchelf/scripts/bmp/npc1.bmp",528,62,550,120);
	click(x7,y7,-400,60)

	x8, y8 =findImageInRegionFuzzy("/var/touchelf/scripts/bmp/npc2.bmp",70,528,70,550,110);
	--x8, y8 =findImageInRegion("/var/touchelf/scripts/bmp/npc2.bmp",528,62,550,120);
	click(x8,y8,-400,60)


	--換對手
	if x7 == -1 and y7 == -1 and x8 == -1 and y8 == -1 then
		x6, y6 =findColorInRegion(0x21927d,26,457,26,457);
		click(x6,y6,0,0)
	end

	--打完繼續
	x9, y9 =findColorInRegion(0x21937d,29,587,29,587);
	click(x9,y9,0,0)

	--再戰一次
	x10, y10 =findColorInRegion(0x21957e,178,597,178,597);
	click(x10,y10,0,0)

	--搶到殘片返回
	x11, y11 =findColorInRegion(0x21947e,179,489,179,489);
	--判斷是搶到殘片還是使用元氣單,搶到殘片才點擊
	x14, y14 =findColorInRegion(0x06242d,304, 589,304, 589);
	if x14 ~= -1 and y14 ~= -1 then
		click(x11,y11,0,0)
	end



	--拼合
	x12, y12 =findColorInRegion(0x218f7a,256,740,256,740);
	click(x12,y12,0,0)

	--拼合完成接受
	--武功 fixed
	x13, y13 =findColorInRegion(0x1f8f79,93,474,93,474);
	click(x13,y13,0,0)
	--裝備 fixed
	x14, y14 =findColorInRegion(0x20917b,93,474,93,474);
	click(x14,y14,0,0)
	--陣法
	x15, y15 =findColorInRegion(0x1e937b,94,482,94,482);
	click(x15,y15,0,0)
	--口訣
	x17, y17 =findColorInRegion(0x20907b,92,475,92,475);
	click(x17, y17,0,0)



	--關閉螢幕保持
	--keepScreen(false);

end

function click(x,y,dx,dy)
    if x ~= -1 and y ~= -1 then
        touchDown(0, (x+dx), (y+dy))   ;
        touchUp(0);
        --mSleep(500);

       --notifyMessage(x);
       --notifyMessage(y);
    else
      -- notifyMessage("no");
    end

end

