#!/system/bin/sh

DTEE="/sbin/cmdd --dtee "
#DTEE="/dfs/bin/cmdd --dtee "
LOGPATH="/persistbackup/diaglog"
RAWLOG="${LOGPATH}/rawlog"
RAWLOG_STDOUT="${LOGPATH}/rawlog.stdout"
RAWLOG_STDERR="${LOGPATH}/rawlog.stderr"
STATION_ENV="${LOGPATH}/stat_env"

function FQC_boot0_and_emmc_lock_check()
{
	local boot0_lock_entry="/sys/class/mmc_host/mmc0/mmc0:0001/block/mmcblk0/mmcblk0boot0/ro_lock"
	local lockdown_flag="2"

	echo "$lockdown_flag" > "$boot0_lock_entry"
	local boot0_lock_status=`cat "$boot0_lock_entry"`

	local card_lock_entry="/sys/class/mmc_host/mmc0/mmc0:0001/card_lock_disable"
	local cardlock_flag="1"

	echo "$cardlock_flag" > "$card_lock_entry"
	local card_lock_status=`cat "$card_lock_entry"`

	if [ "$boot0_lock_status"x = "$lockdown_flag"x ]; then
		echo "boot0 successfully locked down."
	else
		echo "boot0 lockdown fail: flag=$boot0_lock_status"
	fi

	if [ "$card_lock_status"x = "$cardlock_flag" ]; then
		echo "card_lock_disable success"
	else
		echo "card_lock_disable fail: flag=$card_lock_status"
	fi
}

function FQC_end_apk()
{
#	RET=`busybox killall com.lab126.touchstylustest`

	while :
	do
		PS_LINE=`ps | grep com.lab126.touchstylustest`
		if [ $? -ne 0 ];
		then
			break;
		fi
		pid=""
		i=0
		for field in $PS_LINE
		do
			pid=$field
			((i++))
			[ $i -eq 2 ] && break
		done

		kill -9 $pid
		sleep 1
	done

	echo "BatteryMonitorActivity Ends"
}

function FQC_start_battery_control_apk()
{
	range_min=$1
	range_max=$2

	#backlight
	if [ "`cat /sys/class/leds/lcd-backlight/brightness`" = "0" ];then
		input keyevent 26
		sleep 1
	fi

	#unlock screen
	input keyevent 82
	sleep 1

	#start apk
	APK_RET=`am start -n com.lab126.touchstylustest/.BatteryMonitorActivity -d $range_min,$range_max`

	echo "BatteryMonitorActivity Starts"
}

function FQC_battery_charger_control()
{
	local PRODUCT_NAME=`getprop ro.build.product`

	local CHARGE_EN
	local ENABLE_FLAG

	if [ "$PRODUCT_NAME"x = "ariel"x ];
	then
		CHARGE_EN="/sys/devices/platform/battery/Charging_Enable"
		ENABLE_FLAG=1
	elif [ "$PRODUCT_NAME"x = "saturn"x ];
	then
		CHARGE_EN="/sys/bus/i2c/devices/0-005f/suspend_mode"
		ENABLE_FLAG=0
	else
		echo "unsupported product type: $PRODUCT_NAME"
		return
	fi

	case $1 in
		"enable")
			echo $ENABLE_FLAG > $CHARGE_EN
		;;
		"disable")
			((ENABLE_FLAG=!ENABLE_FLAG))
			echo $ENABLE_FLAG > $CHARGE_EN
		;;
		*)
			echo "unsupported control type:$1"
		;;
	esac
set +x
}

function FQC_battery_capacity()
{
	_CAPACITY=""

	case `getprop ro.build.product` in
		"ariel")
		_CAPACITY=`cat  /sys/class/power_supply/battery/capacity`
		;;
		*)
		_CAPACITY=`cat  /sys/class/power_supply/bq27x41/capacity`
		;;
	esac

	if [ "${_CAPACITY}"x != ""x ]; then
		echo ${_CAPACITY}
	else
		echo "-1"
	fi
}

function log_2_round()
{
	local ret=$1
	local log=0

	while [ ${ret} -ne 1 ]
	do
		((ret/=2))
		((++log))
	done

	echo ${log}
}

function power_2()
{
	local ret=1
	local i=0
	local ind=$1

	while [ ${i} -lt ${ind} ]
	do
		((ret*=2))
		((i++))
	done

	echo ${ret}
}

function FQC_emmc_manfid()
{
	i=0
	for tag in `df | grep system`
	do
		tags[$i]=${tag}
		(( i++ ))
	done

	i=0
	for size in `df | grep "/data"`
	do
		sizes[$i]=${size}
		(( i++ ))
	done

	data_img_used=""
	data_img_size=""
	data_img_free=""
	i=0
	while [ $i -lt ${#tags} ]
	do
		case ${tags[$i]} in
			"Size")
				data_img_size=${sizes[$i]}
			;;
			"Used")
				data_img_used=${sizes[$i]}
			;;
			"Free")
				data_img_free=${sizes[$i]}
			;;
		esac
		((i++))
	done

	# Getting emmc's size #
	#set -x
	i=0
	emmc_size=""
	for sect in `cat /proc/partitions | grep "blk0$"`
	do
		((++i))
		if [ $i -eq 3 ]
		then
			emmc_size=${sect}
			((emmc_size--))
			emmc_size=$(log_2_round ${emmc_size})
			((emmc_size++))
			# size-=20 KB->GB
			((emmc_size-=20))
			emmc_size=$(power_2 ${emmc_size})
			emmc_size+="G"
			break;
		fi
	done

	# Using EMMC's size as "Size" #
	#data_img_size=${emmc_size}G
	#set +x

	ret=""
	while [ $# -gt 0 ]
	do
		case "$1" in
			"Size")
				ret+="${data_img_size} "
			;;
			"Used")
				ret+="${data_img_used} "
			;;
			"Free")
				ret+="${data_img_free} "
			;;
			"Emmc_size")
				ret+="${emmc_size} "
		esac
		shift
	done

	echo "$ret"
}

function FQC_idme()
{
	CATAGORY=""
	if [ $# -eq 0 ]; then
		CATAGORY=`ls /proc/idme`
	else
		CATAGORY="$@"
	fi

	for f in ${CATAGORY}
	do
		echo "$f: `cat /proc/idme/$f`"
	done
}

function FQC_image_version()
{
	getprop ro.build.display.id
}

function FQC_otg_test()
{
	TOUCH_IRQ="/sys/bus/i2c/devices/0-0024/main_ttsp_core.cyttsp4_i2c_adapter/drv_irq"

	#==== Unlock Screen ====#
	if [ "`cat /sys/class/leds/lcd-backlight/brightness`" = "0" ];then
		input keyevent 26
		sleep 1
	fi

	#Unlock Screen
	input keyevent 82
	sleep 1

	#set -x
	#Disable Touch
	echo 0 > /sys/bus/i2c/devices/0-0024/main_ttsp_core.cyttsp4_i2c_adapter/drv_irq

	RET=`am start -n com.lab126.touchstylustest/.MouseTestActivity -d 30 2>&1 | grep Error`

	if [ ""x = "${RET}"x ];then
		cat /data/app_log_fifo
	else
		echo "Touch Stylus Test Fail"
	fi

	#Enable Touch
	echo 1 > /sys/bus/i2c/devices/0-0024/main_ttsp_core.cyttsp4_i2c_adapter/drv_irq

	#set +x
}

function FQC_set_station_env()
{
	STATION_ENV_FILE_PATH="/persistbackup/diaglog"
	mkdir -p ${STATION_ENV_FILE_PATH}
	touch ${STATION_ENV_FILE_PATH}/stat_env

	FACTORY="$1"
	LINE="$2"
	STATION="$3"
	PC_HOST="$4"
	OP="$5"

	echo -e\
		""\
		"FACTORY = ${FACTORY}\n"\
		"LINE    = ${LINE}\n"\
		"STATION = ${STATION}\n"\
		"PC_HOST = ${PC_HOST}\n"\
		"OP      = ${OP}" > ${STATION_ENV_FILE_PATH}/stat_env
}

function FQC_set_time() {
	if [ -z "$@" ]; then
		echo "Usage: $0 <date.time>"
		echo "   eg: $0 19990401.090700"
		exit
	fi

	date -s $1 1>/dev/null
	date '+%s'
}

function FQC_shmd()
{
	RET=`am broadcast -a com.amazon.kindle.otter.shipmode 2>/dev/null | grep "result=0"`
	if [ "$RET"x != ""x  ];
	then
			# broadcast succeeds
			echo ";shpm broadcast result: $RET" >> /persistbackup/diaglog/rawlog
			exit
	fi

	# Broadcast fails, Try shipmode in unifisearcher.
	echo "shipmode broadcast fails, Try unifisearcher" >> /persistbackup/diaglog/rawlog

	#==== Unlock Screen ====#
	if [ "`cat /sys/class/leds/lcd-backlight/brightness`" = "0" ];then
		input keyevent 26
		sleep 1
	fi

	#Unlock Screen
	input keyevent 82
	sleep 1

	input keyevent 4
	sleep 1

	input keyevent 4
	sleep 1

	input keyevent 4
	sleep 1

	#Home page
	input keyevent 3
	sleep 1

	#UnifiedUISearcher
	input keyevent 84
	sleep 1

	#;shpm
	input text ";shpm"
	sleep 1

	#enter
	input keyevent 66
	sleep 1

	#
	#input keyevent 26
}

function FQC_touch_cycle() {
	#==== Unlock Screen ====#
	if [ "`cat /sys/class/leds/lcd-backlight/brightness`" = "0" ];then
		input keyevent 26
		sleep 1
	fi

	#Unlock Screen
	input keyevent 82
	sleep 1

	RET=`am start -n com.lab126.touchstylustest/.TouchStylusTestActivity -d 30,7,13,5 2>&1 | grep Error`

	#set -x
	if [ ""x = "${RET}"x ];then
			cat /data/app_log_fifo
	else
			echo "Touch Stylus Test Fail"
	fi
	#set +x
}

function FQC_UTC() {
	_date=`date -u`
	echo ${_date}
}

function FQC_provisioning_check() {
	FINGERPRINT=`/persistbackup/factory_provision_tool info | grep KEY_FINGERPRINT`

	if [ "$FINGERPRINT"x = ""x ];
	then
		echo "fail to find fingerprint field"
	fi

	FINGEPRINT=${FINGERPRINT#KEY*=}

	for _f in ${FINGEPRINT}
	do
		if [ "${_f}"x != "00"x ];
		then
			echo "PASS: non-zero fingerprint [${FINGEPRINT}]"
			return
		fi
	done

	echo "FAIL: zero fingerprint [${FINGEPRINT}]"
}

function ret_error()
{
	echo "Touch Stylus Test Fail"
	exit 1
}

function get_color_code()
{
	DSN=`idme print $1`
	echo ${DSN:$2:$3}
}

function call_apk()
{
	#==== Unlock Screen ====#
	if [ "`cat /sys/class/leds/lcd-backlight/brightness`" = "0" ];then
		input keyevent 26
		sleep 1
	fi

	local timeout=$1
	shift
	local grb_clr=$1

	#Unlock Screen
	input keyevent 82
	sleep 1

	local RET=`am start -n com.lab126.touchstylustest/.WrapperColorTestActivity -d ${grb_clr},${timeout} 2>&1 | grep Error`

	echo ${RET}
}

function FQC_wrapper_color()
{
	# Get color code from dsn
	apk_timeout=$1
	shift
	serial=$1
	shift
	start_byte=$1
	shift
	end_byte=$1
	shift
	clr_code=`get_color_code ${serial} ${start_byte} ${end_byte}`

	# Examine every input "product/clr_code/clr_name/clr_grb" combo string
	APK_RET=""
	while [ "$#" -ne "0" ]
	do
		tmp=$1

		_clr_code=${tmp%%/*}
		tmp=${tmp#*/}

		_clr_name=${tmp%%/*}
		tmp=${tmp#*/}

		_clr_grb=${tmp}

		if [ "${_product_name}" = "${product_name}" -a "${_clr_code}" = "${clr_code}" ]
		then
			echo call apk on $1
			APK_RET=`call_apk ${apk_timeout} ${_clr_grb}`
			break
		fi
		shift
	done

	if [ "$#" -eq "0" ]
	then
		echo "No Matched Color for [${clr_code}]"
		ret_error
	fi

	if [ ""x = "${APK_RET}"x ];then
		echo "APK runs OK, waiting for return"
		cat /data/app_log_fifo
	else
		echo "Fail to start APK"
		ret_error
	fi
}

function FQC_widevine()
{
	TARGET_LOG="/sdcard/wvkeyboxcheckresult.txt"
	APK_COMMAND="com.mediatek.widevine/.WvKeyboxCheck"

	rm ${TARGET_LOG} 2>/dev/null
	#set -x
	RET=`am start -n ${APK_COMMAND} 2>&1 | grep Error`

	for i in 1 2 3
	do
		sleep 1
		[ -f ${TARGET_LOG} ] && echo `cat ${TARGET_LOG}` && return
	done
	#set +x

	echo "$0 fail: no target result file"
}

function FQC_playready()
{
	TARGET_LOG="/sdcard/playreadyProvisioningCheckResult.txt"
	APK_COMMAND="com.mediatek.playready/.PlayreadyProvisioningCheck"

	rm ${TARGET_LOG} 2>/dev/null
	#set -x
	RET=`am start -n ${APK_COMMAND} 2>&1 | grep Error`

	for i in 1 2 3
	do
		sleep 1
		[ -f ${TARGET_LOG} ] && echo `cat ${TARGET_LOG}` && return
	done
	#set +x

	echo "$0 fail: no target result file"
}

function FQC_slimport_test()
{
	CNT=0

	set -x
	while :
	do
		sleep 1
		((CNT++))

		STATE=`cat /sys/bus/i2c/devices/5-0039/ct_switch | grep cable_connected:1`

		if [ -n "${STATE}" ]
		then
			echo "Slimport cabel OK" > /data/app_log_fifo
			exit 0
		elif [ ${CNT} -ge "$1" ]
		then
			echo "Slimport cabel not connected" > /data/app_log_fifo
			exit 1
		fi
	done
}

function FQC_camera_preview()
{
	#==== Unlock Screen ====#
	if [ "`cat /sys/class/leds/lcd-backlight/brightness`" = "0" ];then
		input keyevent 26
		sleep 1
	fi

	#Unlock Screen
	input keyevent 82
	sleep 1

	am start -n com.amazon.camera/.AmazonCameraActivity
}

function log_prefix() {
	mkdir -p ${LOGPATH}
	touch ${RAWLOG}
	touch ${RAWLOG_STDOUT}
	touch ${RAWLOG_STDERR}

	echo "==== TestCase: $CMD ====" | ${DTEE} ${RAWLOG}

	if [ -f "${STATION_ENV}" ]; then
		cat ${STATION_ENV} | ${DTEE} ${RAWLOG}
	else
		echo -e ""\
		"FACTORY = Unknown\n"\
		"LINE    = Unknown\n"\
		"STATION = Unknown\n"\
		"PC_HOST = Unknown\n"\
		"OP      = Unknown" | ${DTEE} ${RAWLOG}
	fi
	echo -e "[$(date '+%m/%d/%Y %H:%M:%S' 2>/dev/null)] Test case starts" \
		"\n>>>>>>>>>>>>>>>>" | ${DTEE} ${RAWLOG}
}

function log_postfix() {
	echo -e "<<<<<<<<<<<<<<<<" \
		"\n[$(date '+%m/%d/%Y %H:%M:%S' 2>/dev/null)] Test case ends\n" \
		| ${BUSYBOX} ${DTEE} ${RAWLOG}
}

CMD="$1"
shift
args="$@"

log_prefix

${CMD} "$@" | ${DTEE} ${RAWLOG}

log_postfix
