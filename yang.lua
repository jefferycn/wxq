package.path=package.path .. ";/var/touchelf/scripts/blood/?.lua"
require "core"

BLOOD_ROUND=400
BLOOD_SKIP_ROUND=333
HARD_ROUND=500
HARD_SKIP_ROUND=400
STAR_ROUND=600
STOP_ROUND=1010
YELLOW_MAX=400
GREEN_MAX=1000
BLUE_MAX=0
PURPLE_RED_RATIO_MIN=0.9
PURPLE_RED_RATIO_MAX=1.1
PID_NAME="/var/touchelf/yang.pid"
CLOSE_GAME=0

function main()
	run();
end