#!/bin/bash

# init pin
sudo bash -c 'echo 203 > /sys/class/gpio/export'
sudo bash -c 'echo in > /sys/class/gpio/gpio203/direction'

IS_MUSIC_PLAYING=false
URL="http://air.aristocrats.fm:8000/live1"
PIN_ADDRESS="/sys/class/gpio/gpio203/value"
SLEEP_TIME=2

echo "Start music-in-the-shower service"
while true; do 
    # read pin value
    LIGHT_PIN_VALUE=$(<$PIN_ADDRESS)

    if [ $LIGHT_PIN_VALUE -eq 0 ] && [ $IS_MUSIC_PLAYING == false ] ; then
        # Light is ON
        echo "Start music"
        sudo mplayer $URL &
        # sudo mpg123 test_sound.mp3 &
        PROC_ID=$!
        IS_MUSIC_PLAYING=true
    elif [ $LIGHT_PIN_VALUE -eq 1 ] && [ $IS_MUSIC_PLAYING == true ] ; then
        # Light is OFF
        echo "Stop Music" 
        sudo kill $PROC_ID
        IS_MUSIC_PLAYING=false
    else
        echo "Idle"
    fi

    sleep $SLEEP_TIME
done 

