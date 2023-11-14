FROM cm2network/steamcmd:root

# Install Night of the Dead
ENV APPDIR "${HOMEDIR}/notd"

# Install wine & winetricks 
ARG WINE_BRANCH="stable"
RUN apt-get update && apt-get install -y gnupg wget xvfb \
	&& wget -nv -O- https://dl.winehq.org/wine-builds/winehq.key | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - \
    && echo "deb https://dl.winehq.org/wine-builds/debian/ $(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2) main" >> /etc/apt/sources.list \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --install-recommends winehq-${WINE_BRANCH} \
    && rm -rf /var/lib/apt/lists/* 
    
RUN wget -nv -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/bin/winetricks
RUN ../steamcmd/steamcmd.sh +force_install_dir ${APPDIR} +login anonymous +app_update 1420710 validate +quit 
RUN chown -R steam:steam ${APPDIR}

RUN  echo "# Crontab file" > crontab.txt \
    echo "0 */4 * * * APPDIR/backup.sh > /dev/null 2>&1" >> crontab.txt
     # Add crontab
   crontab -u steam crontab.txt \
   # Cleanup junk file
   rm crontab.txt
USER ${USER}
RUN winecfg
WORKDIR ${APPDIR}
CMD ["bash", "-c", "wine StartServer.bat"]
