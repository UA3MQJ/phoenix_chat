# Chat

Сделан на базе вот этой инструкции
https://github.com/dwyl/phoenix-chat-example

Подправлен под новый css. Добавлены скрипты для запуске в кластере, чтобы протестить шаринг WS каналов на кластере

docker-compose run -p 4010:4010 testchat1
docker-compose run -p 4010:4010 testchat2

docker-compose build
docker-compose run testchat1
docker-compose run testchat2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
