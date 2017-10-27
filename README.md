# Образ для разработки веб-приложения на Symfony под Docker

Сборка образа
```bash
sudo docker build -t symfony-dev .
```

## Использование

Создание нового проекта
```bash
sudo docker run --rm -it -v $PWD:/symfony \
--mount source=npm-cache,target=/opt/.npm \
--mount source=composer-cache,target=/opt/.composer \
-u $(id -u):$(id -g) \
bskton/symfony-dev symfony new app
```

Запуск приложения в режиме разработки
```bash
sudo docker run --rm -it -v $PWD/app:/symfony \
--mount source=npm-cache,target=/opt/.npm \
--mount source=composer-cache,target=/opt/.composer \
-u $(id -u):$(id -g) \
-p 8000:8000 \
bskton/symfony-dev
```

Открыть страницу http://localhost:8000 в браузере.