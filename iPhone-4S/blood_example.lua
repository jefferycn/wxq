package.path=package.path .. ";/var/touchelf/scripts/blood/?.lua"
require "core"

-- 血战关数
BLOOD_ROUND=280
-- 血战跳过关数
BLOOD_SKIP_ROUND=250
-- 力战关数
HARD_ROUND=380
-- 力战跳过关数
HARD_SKIP_ROUND=320
-- 存星关数
STAR_ROUND=999
-- 停止关数
STOP_ROUND=9990
-- 最大防御
YELLOW_MAX=0
-- 最大身法
GREEN_MAX=1500
-- 最大内力
BLUE_MAX=800
-- 武力：血量 小于此比例将优先武力
PURPLE_RED_RATIO_MIN=1.1
-- 武力：血量 大于此比例将优先血量
PURPLE_RED_RATIO_MAX=0.8
-- 状态文件，支持多账号暂停恢复
PID_NAME="/var/touchelf/a3.pid"
-- 设置为1，会自动关闭游戏
CLOSE_GAME=0

function main()
    run();
end
