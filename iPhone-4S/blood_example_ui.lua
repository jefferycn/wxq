package.path=package.path .. ";/var/touchelf/scripts/blood/?.lua"
require "core"
UI = {
        { 'TextView{-请输入血战各项参数-}'},
        { 'InputBox{}',             'BLOOD_ROUND',    '血战关数' },
        { 'InputBox{}',             'BLOOD_SKIP_ROUND',    '“血战避开”开始关数' },  
        { 'InputBox{}',             'HARD_ROUND',    '力战关数' },
        { 'InputBox{}',             'HARD_SKIP_ROUND',    '“力战避开”开始关数' },   
        { 'InputBox{}',             'YELLOW_MAX',    '防御属性MAX值' },  
        { 'InputBox{}',             'GREEN_MAX',    '身法属性MAX值' },   
        { 'InputBox{}',             'BLUE_MAX',    '内力属性MAX值' },        
        { 'InputBox{}',             'STAR_ROUND',    '存星开始关数' },    
        { 'InputBox{9999}',             'STOP_ROUND',    '停止关数' },          
};

-- 武力：血量 小于此比例将优先武力
PURPLE_RED_RATIO_MIN=0.8
-- 武力：血量 大于此比例将优先血量
PURPLE_RED_RATIO_MAX=1.2
-- 状态文件，支持多账号暂停恢复
PID_NAME="/var/touchelf/a3.pid"
-- 设置为1，会自动关闭游戏
CLOSE_GAME=0
function main()
    BLOOD_ROUND=tonumber(BLOOD_ROUND);
    BLOOD_SKIP_ROUND=tonumber(BLOOD_SKIP_ROUND);
    HARD_ROUND=tonumber(HARD_ROUND);
    HARD_SKIP_ROUND=tonumber(HARD_SKIP_ROUND);
    YELLOW_MAX=tonumber(YELLOW_MAX);
    GREEN_MAX=tonumber(GREEN_MAX);
    BLUE_MAX=tonumber(BLUE_MAX);
    STAR_ROUND=tonumber(STAR_ROUND);
    STOP_ROUND=tonumber(STOP_ROUND);    
    run();    
end