
# Requires

`mplayer`
`ALSA`
`espeak`
`aplay`

# Run

In order to run on startup we will add a root cron job.

This opens up root's crontab. We want to invoke script as root.

```
sudo crontab -e
```

```
# Run job on reboot, but with delay(to be sure that network is accesible).
@reboot sleep 60 && /home/liubko/music-in-the-shower/music-in-the-shower.sh
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
