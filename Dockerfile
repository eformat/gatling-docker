FROM registry.access.redhat.com/ubi8/openjdk-11:latest

ENV GATLING_VERSION 3.2.1
ENV GATLING_HOME /opt/gatling
ENV PATH ${GATLING_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR ${GATLING_HOME}

USER root

RUN mkdir -p /tmp/downloads && \
  curl -sf -o /tmp/downloads/gatling-$GATLING_VERSION.zip \
  -L https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
  mkdir -p /tmp/archive && cd /tmp/archive && \
  unzip /tmp/downloads/gatling-$GATLING_VERSION.zip && \
  mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* ${GATLING_HOME}/ && \
  chown -R jboss:root ${GATLING_HOME} && \
  chmod ugo+x ${GATLING_HOME}/bin/*.sh && \
  chmod -R g=u ${GATLING_HOME}

VOLUME ["${GATLING_HOME}/conf","${GATLING_HOME}/results","${GATLING_HOME}/user-files"]

USER jboss

CMD ["sh", "-c", "${GATLING_HOME}/bin/gatling.sh"]
