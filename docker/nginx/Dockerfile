FROM debian:jessie

RUN apt-get update -qq && apt-get -y install curl

# http://nginx.org/en/download.html
ENV NGINX_VERSION 1.11.5

# https://github.com/pagespeed/ngx_pagespeed/releases
ENV PAGESPEED_VERSION latest-stable

# Releases after 1.11.33.4 there will be a PSOL_BINARY_URL file that tells us where to look, until then this is hardcoded
ENV PAGESPEED_PSOL_VERSION 1.11.33.4

# https://www.openssl.org/source
ENV OPENSSL_VERSION 1.0.2j

RUN useradd -r -s /usr/sbin/nologin nginx && mkdir -p /var/log/nginx /var/cache/nginx
RUN apt-get update -qq && \
    apt-get -y --no-install-recommends install git-core autoconf automake libtool build-essential zlib1g-dev libpcre3-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev

# https://github.com/openresty/headers-more-nginx-module/tags
ENV HEADERS_MORE_VERSION 0.31

RUN echo "Downloading nginx ${NGINX_VERSION} from https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz ..." && curl -sL --ssl-reqd https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar zxf - -C /tmp && \
	echo "Downloading headers-more ${HEADERS_MORE_VERSION} from https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_VERSION}.tar.gz..." && curl -sL --ssl-reqd https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_VERSION}.tar.gz | tar zxf - -C /tmp && \
	echo "Downloading ngx_pagespeed ${PAGESPEED_VERSION} from https://github.com/pagespeed/ngx_pagespeed/archive/${PAGESPEED_VERSION}.tar.gz..." && curl -sL --ssl-reqd https://github.com/pagespeed/ngx_pagespeed/archive/${PAGESPEED_VERSION}.tar.gz | tar zxf - -C /tmp && \
	echo "Downloading pagespeed psol ${PAGESPEED_PSOL_VERSION} from https://dl.google.com/dl/page-speed/psol/${PAGESPEED_PSOL_VERSION}.tar.gz..." && curl -sL --ssl-reqd https://dl.google.com/dl/page-speed/psol/${PAGESPEED_PSOL_VERSION}.tar.gz | tar xzf  - -C /tmp/ngx_pagespeed-${PAGESPEED_VERSION} && \
	echo "Downloading openssl v${OPENSSL_VERSION} from https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz ..." && curl -sL --ssl-reqd https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz | tar xzf  - -C /tmp && \
	cd /tmp/nginx-${NGINX_VERSION} && \
	./configure \
		--prefix=/etc/nginx  \
		--sbin-path=/usr/sbin/nginx  \
		--conf-path=/etc/nginx/nginx.conf  \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp  \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp  \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp  \
		--user=nginx  \
		--group=nginx  \
		--with-http_ssl_module  \
		--with-http_realip_module  \
		--with-http_addition_module  \
		--with-http_sub_module  \
		--with-http_dav_module  \
		--with-http_flv_module  \
		--with-http_mp4_module  \
		--with-http_gunzip_module  \
		--with-http_gzip_static_module  \
		--with-http_random_index_module  \
		--with-http_secure_link_module \
		--with-http_stub_status_module  \
		--with-http_auth_request_module  \
		--without-http_autoindex_module \
		--without-http_ssi_module \
		--with-threads  \
		--with-stream  \
		--with-stream_ssl_module  \
		--with-mail  \
		--with-mail_ssl_module  \
		--with-file-aio  \
		--with-http_v2_module \
		--with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2'  \
		--with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed' \
		--with-ipv6 \
		--with-pcre-jit \
		--with-openssl=/tmp/openssl-${OPENSSL_VERSION} \
		--add-module=/tmp/headers-more-nginx-module-${HEADERS_MORE_VERSION} \
		--add-module=/tmp/ngx_pagespeed-${PAGESPEED_VERSION}  && \
	make && \
	make install && \
	apt-get purge -yqq automake autoconf libtool git-core build-essential zlib1g-dev libpcre3-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev && \
	apt-get autoremove -yqq && \
	apt-get clean && \
	rm -Rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/conf.d/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./bin/* /usr/local/bin/
RUN cd /usr/local/bin/ && chmod 750 docker-entrypoint.sh

ADD webroot /var/webroot
ADD nginx.tmpl /etc/nginx/nginx.tmpl

ENV SSL_CERT_SUBJ "/C=PH/ST=PH/L=PH/O=CDAsia/OU=CDAsia/CN=CAES"

ENV DOCKERIZE_VERSION v0.2.0
RUN curl -sL --ssl-reqd https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar zxf - -C /usr/local/bin

EXPOSE 80 443

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["nginx"]
