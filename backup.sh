#!/bin/bash 
cp -R //home/steam/notd/LF/Saved/SaveGames /home/steam/backup/SaveGames_$(date +%Y%m%d_%T)
find /home/steam/backup/* -type d -ctime +10 -exec rm -rf {} \;
