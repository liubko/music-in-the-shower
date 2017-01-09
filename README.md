
# Requires

`mplayer`
`ALSA`
`espeak`
`aplay`

# Run

in order to run on startup we will add a cron job

```
crontab -e
```

```
# add job
@reboot /home/liubko/music-in-the-shower/main.sh
```

# eSpeak

requires `espeak` and `aplay`

```
espeak --stdout 'Hello' | sudo aplay
```

# Volume

to adjust volume use

```
sudo alsamixer
```
