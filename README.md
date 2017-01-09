
# Run

in order to run on startup we will add a cron job

```
crontab -e
```

```
# add job
@reboot /home/liubko/music-in-the-shower/main.sh &> /home/liubko/music-in-the-shower/LOGS.txt
```
