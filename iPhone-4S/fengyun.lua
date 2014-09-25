
-- 适用屏幕参数
SCREEN_RESOLUTION="640x960";
SCREEN_COLOR_BITS=32;

count=1;
isitend=0;
timeout=0;


--在keepScreen(true)和keepScreen(false)之间屏幕图片内容在内存中保持不变

function main()

    mSleep(2000);
	
   	while count < 6000 and isitend==0 do
	heartBeat();	
	keepScreen(true);
	--小关完结继续战斗,  149,520,0xAFA18B
		skipBtn(  50,595, 0xE14E33);
		skipBtn( 162,591, 0xF1DDA3);
		skipBtn(  67,510, 0x447D7A);
		skipBtn( 387,483, 0x7D1610);
		skipBtn( 109,479, 0x21947D);
		skipBtn(  67,547, 0x396262);
	--2014年6月19日 fanpai
	    skipBtn(  387,512,0x851613);	
    --2014-07-02 更新后		
		skipBtn(  387,512,0x851413);	
        mSleep(100);
		skipBtn( 168,659, 0x194644);				
		mSleep(100);
		--摇钱树后，继续,116,612,0xE8D876
		skipBtn( 116,612,0xE8D876);
		--失败关闭，闭字点 147,486,0xF5EAB1
		skipBtn( 147,486,0xF5EAB1);
				
		count = count + 1;
	--是否回到了主界面
	gc_x1, gc_y1 = findColorInRegion(0xEDD166,  339,750, 339,750);	
	gc_x2, gc_y2 = findColorInRegion(0xD34C26,  339,760, 339,760);		
	gc_x3, gc_y3 = findColorInRegion(0xECDA65,  339,767, 339,767);
    --暴风堂继续 0xF8F8F8 507,533 0x616161 561,515 
 	bf_x1, bf_y1 = findColorInRegion(0xF8F8F8,  507,533,507,533);	
	bf_x2, bf_y2 = findColorInRegion(0x616161,  561,515,561,515);
    --是否在换人中   529,895 0x84A589   533,895 0x16787B
	hr_x1, hr_y1 = findColorInRegion(0x84A589,  529,895,529,895);	
	hr_x2, hr_y2 = findColorInRegion(0x16787B,  533,895,533,895);
   
  --是否全部打完
	over_x1, over_y1 = findColorInRegion(0xEDD166,  339,750, 339,750);	
	over_x2, over_y2 = findColorInRegion(0x909090,  339,760, 339,760);	
  --是否闪退到iphone主界面： 242,649  0x3BB41B  261,620 0xF7E1AD 
	home_x1, home_y1 = findColorInRegion(0x3BB41B,  242,649, 242,649);	
	home_x2, home_y2 = findColorInRegion(0xF7E1AD,  261,620, 261,620);	
  --公告界面  606,22  0xF6F3AD  608,23  0xF6F09E
	note_x1, note_y1 = findColorInRegion(0xF6F3AD,  606,22,606,22);	
	note_x2, note_y2 = findColorInRegion(0xF6F09E,  608,23,608,23);
    --进入风云
	gofy_x1, gofy_y1 = findColorInRegion(0xDACBA9,  370,907,370,907);
    --继续风云
	jxfy_x1, jxfy_y1 = findColorInRegion(0xF7E4B2,  383,715,383,715);

	   
	keepScreen(false);
	--是否回到了主界面
	if gc_x1~= -1 and gc_y1~= -1 and 
	   gc_x2~= -1 and gc_y2~= -1 and 
	   gc_x3~= -1 and gc_y3~= -1
	then   isitend=1;
	end
	
	
	--是否在换人中
	if hr_x1~= -1 and hr_y1~= -1 and 
	   hr_x2~= -1 and hr_y2~= -1
	then   
	 --notifyMessage("换人休息5秒")
	 mSleep(5000);
	end
		
	--暴风堂继续
	if bf_x1~= -1 and bf_y1~= -1 and 
	   bf_x2~= -1 and bf_y2~= -1
	then
     notifyVibrate(3000);
	--notifyMessage("换人休息12秒")
	 mSleep(6000);
	end
	--归云堂继续	
	--天一堂继续	
	--是否全部打完
	if over_x1~= -1 and over_y1~= -1 and 
	   over_x2~= -1 and over_y2~= -1 
	then   isitend=1;
	end
	--闪退后再进去：
	if home_x1~= -1 and home_y1~= -1 and 
	   home_x2~= -1 and home_y2~= -1
	then  
	skipBtn(  261,620, 0xF7E1AD);				
	end
	--点击 进入游戏
	skipBtn( 212,511 , 0xFEDDBA);
	--叉掉公告
	if note_x1~= -1 and note_y1~= -1 and 
	   note_x2~= -1 and note_y2~= -1
	then  
	skipBtn(   608,927 , 0xF0DF9C);	
    mSleep(1000);
	end 
    --进入风云
	if gofy_x1~= -1 and  gofy_y1~= -1
	then
	skipBtn(    370,907, 0xDACBA9);	
	 mSleep(1000);
	end	 
    --继续风云
	if jxfy_x1~= -1 and  jxfy_y1~= -1
	then
	skipBtn(    383,715 ,0xF7E4B2);		
	mSleep(1000);
	end	
	
	
	--notifyMessage('while end')	
--while end
	end
--while end
		
	--notifyVoice('/var/touchelf/music/noticemp3.mp3')
	notifyVibrate(3000);	
    notifyMessage("~~打完了~~")
	mSleep(1000);

end
--main function end


function heartBeat()
	touchDown(0,345,678)
    touchUp(0);
	mSleep(300);
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


