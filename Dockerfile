FROM alpine as builder
RUN apk add --update git;\
    apk add --virtual build-dependencies build-base gcc wget autoconf automake libtool groff libssh-dev openssl-dev
RUN git clone https://github.com/curl/curl.git
RUN cd curl;\
    autoreconf -fi;\
    ./configure;\
    make
RUN make install

FROM scratch
COPY --from=builder /usr/local/bin/curl /usr/local/bin/curl
CMD ["/usr/local/bin/curl"]  
