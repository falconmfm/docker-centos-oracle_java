FROM centos:latest
MAINTAINER  Miguel Angel Falcón <miguel.angel@falc0n.es>

# Instlar Unzip , curl y wget 
RUN yum -y --setopt=tsflags=nodocs update && \
	yum -y install \
		curl wget unzip \
	&& yum clean all

# Versión de Java a descargar. Solo válido para Java 8 ( 7 y anteriores requieren de login)
ENV JAVA_VERSION=8
ENV JAVA_UPDATE=131 
ENV JAVA_BUILD=11 
ENV JAVA_TOKEN=d54c1d3a095b4ff2b6607d096fa80163 

# Establecemos variables de java 
ENV JAVA_HOME /import/software/java17_01
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN cd /tmp && \
	wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
       "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${JAVA_TOKEN}/jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    tar xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mkdir -p "/import/software" && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/import/software"  && \
    ln -s /import/software/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE} ${JAVA_HOME} && \
    rm -rf ${JAVA_HOME}/*src.zip \
    ${JAVA_HOME}/lib/missioncontrol \
    ${JAVA_HOME}/lib/visualvm \
    ${JAVA_HOME}/lib/*javafx* \
    ${JAVA_HOME}/jre/lib/plugin.jar \
    ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
    ${JAVA_HOME}/jre/bin/javaws \
    ${JAVA_HOME}/jre/lib/javaws.jar \
    ${JAVA_HOME}/jre/lib/desktop \
    ${JAVA_HOME}/jre/plugin \
    ${JAVA_HOME}/jre/lib/deploy* \
    ${JAVA_HOME}/jre/lib/*javafx* \
    ${JAVA_HOME}/jre/lib/*jfx* \
    ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
    ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
    ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
    ${JAVA_HOME}/jre/lib/amd64/libglass.so \
    ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
    ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
    ${JAVA_HOME}/jre/lib/amd64/libjfx*.so

# Define default command.
CMD ["/${JAVA_HOME}/bin/java","-version"]
