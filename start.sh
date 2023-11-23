#!/bin/bash 
crontab -u steam /home/steam/crontab.txt
service cron start && service cron status
/home/steam/steamcmd/steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir /home/steam/notd +login anonymous +app_update 1420710 validate +quit 
chown -R steam:steam /home/steam/notd
su steam -c "mkdir -p /home/steam/notd/LF/Saved/Config/"
cp /home/steam/ServerSettings.ini /home/steam/notd/LF/Saved/Config/ServerSettings.ini
cd /home/steam/notd/LF/Binaries/Win64
su steam -c "xvfb-run --auto-servernu wine LFServer.exe ?listen -log -nosteam  -Port=7777 -QueryPort=27015"