.PHONY: start stop

start:
	./music-in-the-shower.sh

stop: stop-main stop-player

stop-player:
	sudo pkill -f ".*mplayer.*" &>/dev/null

stop-main:
	sudo pkill -f ".*music-in-the-shower.*" &>/dev/null
	sudo pkill -f ".*main.sh.*" &>/dev/null

volume:
	sudo alsamixer
