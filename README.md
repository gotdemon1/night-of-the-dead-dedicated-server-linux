# Night of the dead wine for linux dedicated server

<pre>
!!
For now, its not working fine, config in ServerSettings.ini
!!
version: '3.5'
services:
  notd:
    build: .
    container_name: notd
    volumes:
      - ./ServerSettings.ini:/home/steam/notd/ServerSettings.ini
      - ./Saved:/home/steam/notd/LF/Saved
      - ./backup:/home/steam/backup
    ports:
      - 7777:7777/udp
      - 27015:27015/udp
    restart: unless-stopped
    tty: true

</pre>
