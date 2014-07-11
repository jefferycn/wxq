package.path=package.path .. ";/var/touchelf/scripts/blood/?.lua"
require "core"

BLOOD_ROUND=250
BLOOD_SKIP_ROUND=180
HARD_ROUND=320
HARD_SKIP_ROUND=250
STAR_ROUND=999
STOP_ROUND=9999
YELLOW_MAX=600
GREEN_MAX=300
BLUE_MAX=600
PURPLE_RED_RATIO_MIN=0.9
PURPLE_RED_RATIO_MAX=1.1
PID_NAME="/var/touchelf/a3.pid"
CLOSE_GAME=0

function main()
	run();
end