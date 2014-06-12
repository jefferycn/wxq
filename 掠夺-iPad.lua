
-- 适用屏幕参数
SCREEN_RESOLUTION="1536x2048";
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
	x, y =findColorInRegion(0x136156,168,1025,168,1025);
	click(x,y,0,0)
	touchDown(0,540, 570)
    touchUp(0);
	mSleep(300);
   	x, y =findColorInRegion(0x136156,168,1025,168,1025);
	click(x,y,0,0)

    --touchDown(0, 540, 570)
    --touchUp(0);

	--開啟螢幕保持,find color及find image不重抓圖來判斷,加速效能
	-- keepScreen(true);

    --找殘片
	x1, y1 =findColorInRegion(0x1e3a4d,1095,560,1095,560);
	click(x1, y1,0,0)

	x2, y2 =findColorInRegion(0x1b3e45,948,855,948,855);
	click(x2,y2,0,0)

	x3, y3 =findColorInRegion(0x1a3d4c,668,849,668,849);
	click(x3,y3,0,0)

	x4, y4 =findColorInRegion(0x1a3d4c,668,257,668,257);
	click(x4,y4,0,0)

	x5, y5 =findColorInRegion(0x193c4b,948,257,948,257);
	click(x5,y5,0,0)

	x16, y16 =findColorInRegion(0x1a3c45,530,560,530,560);
	click(x16,y16,0,0)




	--找NPC名字
	x7, y7 =findImageInRegionFuzzy("/var/touchelf/scripts/bmp/npc1-ipad.bmp",70,1210,150,1257,233);
	click(x7,y7,-870,70)

	x8, y8 =findImageInRegionFuzzy("/var/touchelf/scripts/bmp/npc2-ipad.bmp",70,1210,150,1257,233);
	click(x8,y8,-870,70)


	--換對手
	if x7 == -1 and y7 == -1 and x8 == -1 and y8 == -1 then
		x6, y6 =findColorInRegion(0x21947e,140,1035,140,1035);
		click(x6,y6,0,0)
	end

	--打完繼續
	x9, y9 =findColorInRegion(0x21947d,155,1255,155,1255);
	click(x9,y9,0,0)

	--再戰一次
	x10, y10 =findColorInRegion(0x1f8d78,472,1272,472,1272);
	click(x10,y10,0,0)

	--搶到殘片返回
	x11, y11 =findColorInRegion(0x1f8e78,472,1055,472,1055);
	--判斷是搶到殘片還是使用元氣單,搶到殘片才點擊
	x14, y14 =findColorInRegion(0x968b6b,501,1083,501,1083);
	if x14 ~= -1 and y14 ~= -1 then
		click(x11,y11,0,0)
	end



	--拼合
	x12, y12 =findColorInRegion(0x21947d,644,1571,644,1571);
	click(x12,y12,0,0)

	--拼合完成接受
	--武功
	x13, y13 =findColorInRegion(0x1d947c,288,1015,288,1015);
	click(x13,y13,0,0)
	--裝備
	x14, y14 =findColorInRegion(0x1d947c,288,1015,288,1015);
	click(x14,y14,0,0)
	--陣法
	x15, y15 =findColorInRegion(0x414e58,288,1015,288,1015);
	click(x15,y15,0,0)
	--口訣
	x17, y17 =findColorInRegion(0x1b8a75,288,1015,288,1015);
	click(x17, y17,0,0)



	--關閉螢幕保持
	-- keepScreen(false);

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

