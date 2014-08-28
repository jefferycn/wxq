# 武侠Q传 辅助脚本

我相信玩这个游戏的人，都会觉得昆仑和火谷有多么的坑人。一个卡牌游戏，能够浪费大家那么多的时间，简直就是一个非人的存在。因此，公开此脚本以节约更多人的时间。

** 禁止使用此源码用作任何商业用途 **

** 欢迎完善、以及扩展此脚本，用以无偿给更多的人方便 **

Jeffery Allrights Reserved, [http://youjf.com/](http://youjf.com/)

## 需求

* iPhone 4/ iPhone 4S
* 越狱
* touchelf [触摸精灵](http://www.touchelf.com/)
* 然后是一根充电线， 太费电了，有木有？！

## 安装 touchelf

有动手能力的同学，直接访问官网安装即可。[官网](http://www.touchelf.com/)

或者看别人写的安装教程。 [http://www.weixinjizan.com/ios.htm](http://www.weixinjizan.com/ios.htm)

> 非注册设备，可以运行一个小时，大部分时间够用。如果脚本自动停止了，再次开启即可。

## 脚本运行

touchelf 安装目录在 `/var/touchelf/`，我们的脚本放在 `/var/touchelf/scripts/` 目录。下载相应的脚本，放在该目录，即可在 `触摸精灵` 应用的列表中看到脚本。

运行流程：

* 打开 `触摸精灵` 应用
* 选择想要运行的脚本，点 `手动播放`
* 切换到 `武侠Q传`，然后到相应的页面，按音量键 +/- 即可启动脚本
* 再次按音量键 +/- 即可停止脚本

以血战为例，脚本位置为：

```
/var/touchelf/scripts/blood_example.lua
/var/touchelf/scripts/blood/core.lua
```

## 目前已有脚本说明

### 血战脚本

目前仅支持 iPhone4、iPhone4S

所需脚本文件 `iPhone-4S/blood_exmple.lua`, `iPhone-4S/blood/core.lua`。blood_exmple.lua 为配置文件，如果有多个帐号，复制多份配置文件，使用不同的 `PID_NAME` 即可。

触摸精灵 应用里可以看到每一次脚本完成时的状态。

> 血战的启动应该在 “奇遇” -> “魔教总坛” -> “勇闯” 以后。
> 如果是从第一关开始，在选择加成之前按下音量键，3秒以后脚本开始自动执行。
> 如果中途有停止过，点击 “奇遇” -> “魔教总坛” -> “继续” 以后，按下音量键，3秒以后脚本开始自动执行。
> 如果设置了 `STOP_ROUND=999` 那么脚本会在打完998关的时候停止。此时，如果需要清除记录的状态，在 “奇遇” -> “魔教总坛” 按下音量键，脚本会清除此前记录的数据，领取血战奖励。或者可以手动删除 `/var/touchelf/a3.pid` 以清除状态数据。

配置说明：

```
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
```

### 掠夺脚本

所需脚本文件 `iPhone-4S/rob.lua`, `iPhone-4S/wxqpic/*`。

> “掠夺” “武功” 按下音量键开始。
> 装备，阵法，口诀 可能会在拼合以后停止


### 不败脚本

所需脚本文件 `iPhone-4S/bubai.lua`。

> “不败神话” -> “挑战” 按下音量键开始。
> 不使用元宝。

### 风云脚本

所需脚本文件 `iPhone-4S/fengyun.lua`。

> 风云脚本不会自动帮你选择阵容，请在需要跳过战斗的界面按下音量键即可。