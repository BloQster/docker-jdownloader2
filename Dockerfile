FROM ubuntu:xenial
MAINTAINER michael.bortlik@gmail.com

ENV JDOWNLOADER2_INSTALLDIR="/opt/jdownloader2" \
    JDOWNLOADER2_CONFIGGILE="/opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"

RUN useradd -M -d ${JDOWNLOADER2_INSTALLDIR} jdownloader2

RUN apt-get update \
 && apt-get install -y openjdk-8-jre-headless \
 && rm -r /var/lib/apt/lists/*

RUN mkdir -p ${JDOWNLOADER2_INSTALLDIR} ${JDOWNLOADER2_INSTALLDIR}/cfg
ADD ./JDownloader.jar ${JDOWNLOADER2_INSTALLDIR}

RUN java -jar $JDOWNLOADER2_INSTALLDIR/JDownloader.jar -norestart
RUN chown -R jdownloader2:jdownloader2 ${JDOWNLOADER2_INSTALLDIR}

VOLUME ${JDOWNLOADER2_INSTALLDIR}/cfg

ADD /jdownloader2_entrypoint.sh /
RUN chmod +x /jdownloader2_entrypoint.sh
ENTRYPOINT ["/jdownloader2_entrypoint.sh"]