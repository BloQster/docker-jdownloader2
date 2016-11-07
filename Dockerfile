FROM ubuntu:latest

ENV MY_JDOWNLOADER_MAIL=NOT_SET \
	MY_JDOWNLOADER_PASSWORD=NOT_SET

	RUN apt-get update && \
	apt-get install -y openjdk-8-jre-headless nano expect sed && \
	rm -r /var/lib/apt/lists/* && \
	mkdir /opt/jdownloader && \
	useradd -M -d /opt/jdownloader -s /bin/bash jdownloader
ADD ./JDownloader.jar ./start.sh /opt/jdownloader/
ADD ./org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json /opt/jdownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json
RUN chown -R jdownloader:jdownloader /opt/jdownloader && \
	chmod +x /opt/jdownloader/start.sh
USER jdownloader
WORKDIR /opt/jdownloader
RUN java -jar JDownloader.jar
ENTRYPOINT /opt/jdownloader/start.sh
