FROM debian:stable-slim

LABEL org.opencontainers.image.source=https://github.com/celsomiranda/calibre-server/
LABEL org.opencontainers.image.description="Calibre Server"
LABEL org.opencontainers.image.licenses=MIT


RUN sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list.d/debian.sources
RUN apt-get update && apt-get install -y calibre imagemagick rsync python3-unrardll unrar
RUN mkdir /srv/calibre
RUN mkdir /srv/calibre/log

COPY scripts/calibre-server.sh /usr/local/bin/calibre-server.sh
ADD files/library /usr/local/share/calibre/library
RUN chmod a+x /usr/local/bin/calibre-server.sh

# define entrypoint
ENTRYPOINT /usr/local/bin/calibre-server.sh

# run sleep infinity
CMD [ "/usr/bin/sleep", "infinity" ]

EXPOSE "8080"

ARG CALIBRE_LIBRARY_PATH="/srv/calibre/library"
ARG CALIBRE_OPTIONS=""
ARG CALIBRE_NEW_BOOKS_PATH="/srv/calibre/new"
ARG CALIBRE_USERDB_PATH=""
