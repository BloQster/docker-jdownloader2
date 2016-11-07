#!/bin/bash
set -e

if [ ! -f /opt/jdownloader/init-script-completed ]; 
then
	if [-z $MY_JDOWNLOADER_MAIL || -z $MY_JDOWNLOADER_PASSWORD ]; then
		echo "MyJDownloader mail or password ist not set."
		exit 100
	fi	
	sed -i -e s/MY_JDOWNLOADER_EMAIL/$MY_JDOWNLOADER_MAIL/ -e s/MY_JDOWNLOADER_PASSWORD/$MY_JDOWNLOADER_PASSWORD/ /opt/jdownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
	touch /opt/jdownloader/init-script-completed	
fi
java -jar /opt/jdownloader/JDownloader.jar
