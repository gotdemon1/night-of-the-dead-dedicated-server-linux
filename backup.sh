#!/bin/bash 
cp -R /home/steam/notd/LF/Saved/SaveGames /home/steam/backup/Save_$(date +%Y%m%d_%T)
find /home/steam/backup/* -type d -ctime +2 -exec rm -rf {} \;
