FROM ubuntu:xenial
MAINTAINER michael.bortlik@gmail.com

ENV JDOWNLOADER2_INSTALLDIR="/opt/jdownloader2" \
    JDOWNLOADER2_CONFIGGILE="/opt/jdownloader2/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"

RUN useradd -M -d ${JDOWNLOADER2_INSTALLDIR} jdownloader2

RUN apt-get update \
 && apt-get install -y wget software-properties-common \
 && add-apt-repository ppa:webupd8team/java -y \
 && apt-get update \
 && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
 && apt-get install oracle-java8-installer -y \
 && rm -r /var/lib/apt/lists/*

RUN mkdir -p ${JDOWNLOADER2_INSTALLDIR} ${JDOWNLOADER2_INSTALLDIR}/cfg \
 && wget -O ${JDOWNLOADER2_INSTALLDIR}/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar

RUN java -jar $JDOWNLOADER2_INSTALLDIR/JDownloader.jar -norestart \
 && chown -R jdownloader2:jdownloader2 ${JDOWNLOADER2_INSTALLDIR}

VOLUME ${JDOWNLOADER2_INSTALLDIR}/cfg

ADD /jdownloader2_entrypoint.sh /
RUN chmod +x /jdownloader2_entrypoint.sh
ENTRYPOINT ["/jdownloader2_entrypoint.sh"]
