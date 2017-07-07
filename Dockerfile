FROM centos:latest
MAINTAINER  Miguel Angel Falcón <miguel.angel@falc0n.es>

# install curl so we can
RUN yum -y --setopt=tsflags=nodocs update && \
	&& yum -y install \
		curl wget unzip 
	&& yum clean all

# Java Version
ENV JAVA_VERSION_MAJOR 7
ENV JAVA_VERSION_MINOR 79
ENV JAVA_VERSION_BUILD 15
ENV JAVA_PACKAGE jdk
# Set environment
ENV JAVA_HOME /import/software/java17_01
ENV PATH ${PATH}:${JAVA_HOME}/bin

# Download and unarchive Java
RUN \
  curl --fail --retry 3 --insecure --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"\
  --location http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz -#\
  | gunzip | tar x -C /import/software && \
  ln -s /import/software/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} $JAVA_HOME && \
  rm -rf $JAVA_HOME/*src.zip \
    /$JAVA_HOME/lib/missioncontrol \
    /$JAVA_HOME/lib/visualvm \
    /$JAVA_HOME/lib/*javafx* \
    /$JAVA_HOME/jre/lib/plugin.jar \
    /$JAVA_HOME/jre/lib/ext/jfxrt.jar \
    /$JAVA_HOME/jre/bin/javaws \
    /$JAVA_HOME/jre/lib/javaws.jar \
    /$JAVA_HOME/jre/lib/desktop \
    /$JAVA_HOME/jre/plugin \
    /$JAVA_HOME/jre/lib/deploy* \
    /$JAVA_HOME/jre/lib/*javafx* \
    /$JAVA_HOME/jre/lib/*jfx* \
    /$JAVA_HOME/jre/lib/amd64/libdecora_sse.so \
    /$JAVA_HOME/jre/lib/amd64/libprism_*.so \
    /$JAVA_HOME/jre/lib/amd64/libfxplugins.so \
    /$JAVA_HOME/jre/lib/amd64/libglass.so \
    /$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so \
    /$JAVA_HOME/jre/lib/amd64/libjavafx*.so \
    /$JAVA_HOME/jre/lib/amd64/libjfx*.so

# Define default command.
CMD ["/$JAVA_HOME/bin/java","-version"]
