#!/bin/bash

LOG_FILE="`dirname $0`/LOGS.txt"
IS_MUSIC_PLAYING=false
URL="http://air.aristocrats.fm:8000/live1"
PIN_ADDRESS="/sys/class/gpio/gpio203/value"
SLEEP_TIME=2

# adds timestamp before echo and writes to file
echo_time() {
    date +"%D %R $*" >> $LOG_FILE
}

echo_time "[Start music-in-the-shower service]"

# init pin
LIGHT_PIN_VALUE=""
while [ -z $LIGHT_PIN_VALUE ]; do # check if empty string
    echo_time "[Init Pin]"
    
    sudo bash -c 'echo 203 > /sys/class/gpio/unexport'
    sudo bash -c 'echo 203 > /sys/class/gpio/export'
    sudo bash -c 'echo in > /sys/class/gpio/gpio203/direction'
    
    # read pin value
    LIGHT_PIN_VALUE=$(<$PIN_ADDRESS)
    # echo_time "[Pin value is: $LIGHT_PIN_VALUE]"
done

while true; do 
    # read pin value
    LIGHT_PIN_VALUE=$(<$PIN_ADDRESS)

    if [ $LIGHT_PIN_VALUE -eq 0 ] && [ $IS_MUSIC_PLAYING == false ] ; then
        espeak --stdout "It's nice to see you!" | sudo aplay

       # Light is ON
        echo_time "[Start music]"
        
        # To play `*.mp3` use `mpg123`
        # sudo mpg123 test_sound.mp3 &
        
        # run music in background and save PID
        sudo mplayer -vo null -ao alsa $URL &>>$LOG_FILE &
        PROC_ID=$!

        IS_MUSIC_PLAYING=true
    elif [ $LIGHT_PIN_VALUE -eq 1 ] && [ $IS_MUSIC_PLAYING == true ] ; then
        # Light is OFF
        echo_time "[Stop Music]" 
        sudo kill $PROC_ID
        IS_MUSIC_PLAYING=false
        espeak --stdout "Sorry to see you go. Bye." | sudo aplay
    # else
        # echo_time "[Idle | IS_MUSIC_PLAYING=$IS_MUSIC_PLAYING | LIGHT_PIN_VALUE=$LIGHT_PIN_VALUE]"
    fi

    sleep $SLEEP_TIME
done 
