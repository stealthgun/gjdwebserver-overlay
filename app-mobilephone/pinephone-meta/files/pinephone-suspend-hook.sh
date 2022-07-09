#!/bin/bash
# PinePhone suspend / wakeup modem
# /usr/lib/systemd/system-sleep/pinephone-modem-suspend.sh

# DTR is:     
# - PL6/GPIO358 on BH (1.1)
# - PB2/GPIO34 on CE (1.2)

# AP_READY is:                  
# - PL2/GPIO354 on BH (1.1)
# - PH7/GPIO231 on CE (1.2)

LOGFILE=/var/log/pp-suspend.log

if grep -q 1.1 /proc/device-tree/model
then 
     DTR=358
     AP_READY=354
else
     DTR=34
     AP_READY=231
fi

if [ ! -f ${LOGFILE} ]; then
     touch ${LOGFILE}
fi

prepare_suspend() {
	# Enable URC caching
	echo -ne 'AT+QCFG="urc/cache",1\r' > /dev/ttyS2
	
	# Put modem in power saving mode
	# Note: GPIO231 is WAKEUP_IN on BH and AP_READY on CE
	#  - BH: WAKEUP_IN must be high to enable power saving mode
	#  - CE: AP_READY (active low) must be high to indicate host sleep
	# In both cases DTR (GPIO358) must be high to enable power saving mode
    	NOW=`date`
    	echo "$NOW Entering suspend" >> ${LOGFILE}
    	echo 1 > /sys/class/gpio/gpio${AP_READY}/value
    	echo 1 > /sys/class/gpio/gpio${DTR}/value
	echo -ne 'AT+QSCLK=1\r' > /dev/ttyS2
}

resume_all() {
	# Wake up modem
	echo -ne 'AT+QSCLK=0\r' > /dev/ttyS2
    	echo 0 > /sys/class/gpio/gpio${AP_READY}/value
    	echo 0 > /sys/class/gpio/gpio${DTR}/value
    	NOW=`date`
    	echo "$NOW Exiting suspend" >> ${LOGFILE}
	
	# Disable URC caching
	echo -ne 'AT+QCFG="urc/cache",0\r' > /dev/ttyS2
}

case $1 in
	pre) prepare_suspend ;;
	post) resume_all ;;
esac
