FROM phpswoole/swoole

COPY ./src/ /app

RUN \
    pecl update-channels        && \
    pecl install mongodb          && \
    docker-php-ext-enable mongodb

WORKDIR /app

CMD ["./application"]