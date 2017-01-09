#!/bin/bash

# setup logs
LOG_FILE=LOGS.log
exec > >(tee -a ${LOG_FILE} )
exec 2> >(tee -a ${LOG_FILE} >&2)

# adds timestamp before echo
echo_time() {
    date +"%R $*"
}

# init pin
sudo bash -c 'echo 203 > /sys/class/gpio/export'
sudo bash -c 'echo in > /sys/class/gpio/gpio203/direction'

IS_MUSIC_PLAYING=false
URL="http://air.aristocrats.fm:8000/live1"
PIN_ADDRESS="/sys/class/gpio/gpio203/value"
SLEEP_TIME=2

echo_time "[Start music-in-the-shower service]"
while true; do 
    # read pin value
    LIGHT_PIN_VALUE=$(<$PIN_ADDRESS)

    if [ $LIGHT_PIN_VALUE -eq 0 ] && [ $IS_MUSIC_PLAYING == false ] ; then
        # Light is ON
        echo_time "[Start music]"
        
        # To play `*.mp3` use `mpg123`
        # sudo mpg123 test_sound.mp3 &
        
        # run music in background and save PID
        sudo mplayer -vo null -ao alsa $URL &
        PROC_ID=$!

        IS_MUSIC_PLAYING=true
    elif [ $LIGHT_PIN_VALUE -eq 1 ] && [ $IS_MUSIC_PLAYING == true ] ; then
        # Light is OFF
        echo_time "[Stop Music]" 
        sudo kill $PROC_ID
        IS_MUSIC_PLAYING=false
    else
        echo_time "[Idle]"
    fi

    sleep $SLEEP_TIME
done 

