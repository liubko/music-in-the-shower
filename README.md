# Requirements

## Hardware

- [NanoPI M1 512Mb RAM](http://arduino-ua.com/prod1569-nanopi-m1-512mb-ram)
- [Sunny 5В microUSB 2,1A](http://arduino-ua.com/prod1591-blok-pitaniya-5v-microusb-2-1a)
- [MicroSD card 16GB Class 10](http://arduino-ua.com/prod869-microsd-karta-silicon-power-16gb-class-10--adapter)
- [Photoresistor](http://arduino-ua.com/prod1213-modyl-datchika-osveshhennosti)
- [Wi-Fi adapter Ralink (optional)](http://arduino-ua.com/prod576-Miniaturnii_Wi-Fi_adapter_Ralink)
- Speakers

## Software

Installed `Debian GNU/Linux 8.6 (jessie)` _([How to install](http://wiki.friendlyarm.com/wiki/index.php/NanoPi_M1#Make_an_Installation_TF_Card))_

Also you have to install:
- `mplayer`
- `ALSA`
- `espeak`
- `aplay`

# Run

Several shortcut commands available
```
make start // start service
make stop // stop service
make volume // run alsamixer to adjust volume
```

# Autorun

In order to run on startup add a __root__ cron job.

To edit crontab jobs.

```
sudo crontab -e
```

```
# Run job on reboot, but with delay(to make sure that network is accesible).
@reboot sleep 60 && /home/liubko/music-in-the-shower/music-in-the-shower.sh
```
