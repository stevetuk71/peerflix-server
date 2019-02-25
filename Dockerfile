FROM node:6-alpine

# Update latest available packages,
# add 'app' user, and make temp directory
RUN apk --no-cache add ffmpeg git && \
    npm install -g grunt-cli bower && \
    adduser -D app && \
    mkdir /tmp/torrent-stream && \
    chown app:app /tmp/torrent-stream

WORKDIR /home/app
RUN git clone https://github.com/moafyuk/peerflix-server.git
WORkDIR /home/app/peerflix-server
COPY . .
RUN chown app:app /home/app -R

# run as user app from here on
USER app
RUN npm install && \
    bower --allow-root install && \
    grunt build

VOLUME [ "/tmp/torrent-stream" ]
EXPOSE 9000

CMD [ "npm", "start" ]
