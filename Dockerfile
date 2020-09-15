FROM debian:buster as build
#MAINTAINER amene.deljoo@gmail.com
ARG secrets.GIT_TOKEN
ENV tenantuserid=1073
ENV USERID $tenantuserid
#ENV GID $tenantuserid
RUN addgroup --gid $USERID dsh \
   && adduser \
   --disabled-password \
   --gecos "" \
   --home "$(pwd)" \
   --ingroup dsh \
   --no-create-home \
  # --force-badname\
   --uid $USERID \
   dsh

# Download and install hugo
RUN apt-get -qq update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends apt-utils libstdc++6 python-pygments git ca-certificates asciidoc curl \
	&& rm -rf /var/lib/apt/lists/*

ENV  HUGO_VERSION 0.68.2
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.deb
RUN curl -sL -o /tmp/hugo.deb \
    https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

ENV HUGO_APPEND_PORT true
ENV HUGO_BASE_URL https://autogit.poc.kpn-dsh.com

COPY scripts/*.sh  scripts/

RUN chmod +x scripts/*.sh

RUN mkdir /site
RUN chown -R $USERID.$USERID /site

USER dsh
#EXPOSE 1313
# Load the entry point
ENTRYPOINT [ "/scripts/entrypoint.sh" ]
CMD ["/bin/bash", "-c",  "hugo server --disableFastRender -b ${HUGO_BASE_URL} --bind=0.0.0.0","printenv"]
