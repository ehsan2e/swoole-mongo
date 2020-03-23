# Nonblocking MongoDB Connection in Swoole

While there is no official mongodb client for swoole and PHP mongodb-ext is blocking [as mentioned here](https://www.swoole.co.uk/docs/modules/swoole-coroutine-methods#runtime-enablecoroutine) and [demonstrated here](https://github.com/proophsoftware/swoole-mongo-test) we can use [swoole coroutine client](https://www.swoole.co.uk/docs/modules/swoole-coroutine-client) to run our queries agains MongoDB in a nonblocking manner using [MongoDB Wire Protocol](https://docs.mongodb.com/manual/reference/mongodb-wire-protocol). This is my naive implementation of this idea.

## Set up

```php
$ docker-compose up -d
```

## Test
The application has three routes as follows:
- http://localhost:9501 Use this route to test if the application is responsive while your request to any of the other two routes is in progress it should resolve immediately for the right route and it should hang for the wrong route.
- http://localhost:9501?wrong This route uses the mongodb extension to run a slow query against database so it responds after 10 seconds and blocks all other calls
- http://localhost:9501?right This route uses MongoDB wire protocol and swoole coroutine client to run a slow query against database so it responds after 10 seconds but it does not block other calls

## Errors
If the solution fails to start make sure that the `src/application` is executable or change the `CMD` section in the `Dockerfile` to:
```
CMD ["php", "application"]
```
