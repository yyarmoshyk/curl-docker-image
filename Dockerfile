FROM alpine as builder
ARG curl_version
RUN apk add --update --virtual build-dependencies build-base;\
    apk add wget git autoconf automake libtool groff libssh-dev openssl-dev unzip

# RUN git clone https://github.com/curl/curl.git
RUN wget https://github.com/curl/curl/archive/curl-$(echo ${curl_version} |sed 's/\./_/g').zip;\
    unzip curl-$(echo ${curl_version} |sed 's/\./_/g').zip
RUN cd curl-curl-$(echo ${curl_version} |sed 's/\./_/g');\
    autoreconf -ifs -W none;\
    ./configure --with-ssh --with-libssh;\
    make;\
    make install

# The following problem occurs with a specific sequence of COPY commands in a multistage build:
#   failed to export image: failed to create image: failed to get layer
# A workaround could be to add RUN true between COPY statements:


FROM alpine
COPY --from=builder /usr/local/bin/curl /bin/curl
RUN true
COPY --from=builder /usr/local/lib/libcurl.a /usr/local/lib/
RUN true
COPY --from=builder /usr/local/lib/libcurl.la /usr/local/lib/
RUN true
COPY --from=builder /usr/local/lib/libcurl.so.4.7.0 /usr/local/lib/
RUN true
COPY --from=builder /usr/lib/libssh.so.4 /usr/lib/libssh.so.4
RUN true
COPY --from=builder /lib/ld-musl-x86_64.so.1 /lib/
RUN true
COPY --from=builder /lib/libssl.so.1.1 /lib/
RUN true
COPY --from=builder /lib/libcrypto.so.1.1 /lib/
RUN true
COPY --from=builder /lib/libz.so.1 /lib/
RUN true
RUN cd /usr/local/lib/;\
    ln -s libcurl.so.4.7.0 libcurl.so;\
    ln -s libcurl.so.4.7.0 libcurl.so.4
RUN ldconfig -n /usr/local/lib
USER nobody
HEALTHCHECK CMD /bin/curl --version
ENTRYPOINT ["/bin/curl"]
