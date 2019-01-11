FROM openjdk:8-jre

ARG VERSION

RUN curl -Lo /opt/iri.jar https://github.com/iotaledger/iri/releases/download/v${VERSION}-RELEASE/iri-${VERSION}-RELEASE.jar

RUN useradd -m -u 1000 -s /bin/bash runner
USER runner

WORKDIR /opt/data

ENTRYPOINT ["java", "-jar", "/opt/iri.jar"]
