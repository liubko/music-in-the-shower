#!/bin/bash

# init pin
sudo bash -c 'echo 203 > /sys/class/gpio/export'
sudo bash -c 'echo in > /sys/class/gpio/gpio203/direction'

LOG_FILE="`dirname $0`/LOGS.txt"
IS_MUSIC_PLAYING=false
URL="http://air.aristocrats.fm:8000/live1"
PIN_ADDRESS="/sys/class/gpio/gpio203/value"
SLEEP_TIME=2

# adds timestamp before echo and writes to file
echo_time() {
    date +"%D %R $*" >> $LOG_FILE
}

echo_time "\n\n[Start music-in-the-shower service]"
while true; do 
    # read pin value
    LIGHT_PIN_VALUE=$(<$PIN_ADDRESS)

    if [ $LIGHT_PIN_VALUE -eq 0 ] && [ $IS_MUSIC_PLAYING == false ] ; then
        espeak --stdout "Welcome to the Bathroom" | sudo aplay
        espeak --stdout "Let's play some music now" | sudo aplay

       # Light is ON
        echo_time "[Start music]"
        
        # To play `*.mp3` use `mpg123`
        # sudo mpg123 test_sound.mp3 &
        
        # run music in background and save PID
        sudo mplayer -vo null -ao alsa $URL &>/dev/null &
        PROC_ID=$!

        IS_MUSIC_PLAYING=true
    elif [ $LIGHT_PIN_VALUE -eq 1 ] && [ $IS_MUSIC_PLAYING == true ] ; then
        # Light is OFF
        echo_time "[Stop Music]" 
        sudo kill $PROC_ID
        IS_MUSIC_PLAYING=false
        espeak --stdout "Sorry to see you go. Bye." | sudo aplay
    else
        echo_time "[Idle | IS_MUSIC_PLAYING=$IS_MUSIC_PLAYING | LIGHT_PIN_VALUE=$LIGHT_PIN_VALUE]"
    fi

    sleep $SLEEP_TIME
done 

