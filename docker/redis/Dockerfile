FROM redis:3.2

ENV REDIS_HOME /var/lib/redis

RUN mkdir $REDIS_HOME && chown -R redis:redis $REDIS_HOME
VOLUME $REDIS_HOME
WORKDIR $REDIS_HOME
COPY ./redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf"]