#!/bin/bash
set -e

if [ ! -f "$JDOWNLOADER2_CONFIGGILE" ]; then
    if [ -z "$MYJDOWNLOADER_EMAIL" ]; then
        echo "MyJDownloader mail is not set."
        exit 1
    fi

    if [ -z "$MYJDOWNLOADER_PASSWORD" ]; then
        echo "MyJDownloader password is not set."
        exit 1
    fi
    
    if [ -z "$MYJDOWNLOADER_DEVICENAME" ]; then
        echo "MyJDownloader password is not set."
        exit 1
    fi

    cat <<- EOF > $JDOWNLOADER2_CONFIGGILE
{
  "uniquedeviceidsaltv2" : "",
  "autoconnectenabledv2" : true,
  "debugenabled" : false,
  "uniquedeviceid" : null,
  "lastlocalport" : 42476,
  "connectip" : "api.jdownloader.org",
  "latesterror" : "NONE",
  "password" : "${MYJDOWNLOADER_PASSWORD}",
  "clientconnectport" : 80,
  "directconnectmode" : "LAN",
  "devicename" : "${MYJDOWNLOADER_DEVICENAME}",
  "uniquedeviceidv2" : "",
  "email" : "${MYJDOWNLOADER_EMAIL}"
}
EOF
     
fi

exec start-stop-daemon --start --chuid jdownloader2:jdownloader2 --exec /usr/bin/java -- -Djava.awt.headless=true -jar "$JDOWNLOADER2_INSTALLDIR"/JDownloader.jar
