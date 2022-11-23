# Telegram to Pocket bot

[![CI](https://github.com/mishankov/telegram-to-pocket-bot/actions/workflows/ci.yml/badge.svg)](https://github.com/mishankov/telegram-to-pocket-bot/actions/workflows/ci.yml)

Save bookmarks to [Pocket](https://getpocket.com/) sending links to [Telegram](https://telegram.org/) bot

## Using

### Instalation

You can use Windows, Ubuntu or macOS executables provided in the [latest release](https://github.com/mishankov/telegram-to-pocket-bot/releases/latest), but preferred way is to use Docker and Docker Compose.

To do it clone this repo

```bash
git clone https://github.com/mishankov/telegram-to-pocket-bot.git
cd telegram-to-pocket-bot
```
Then create `.env` file with folowing environment variables:

- `TELEGRAM_BOT_TOKEN` - Telegram Bbot token provided by BotFather. [Docs](https://core.telegram.org/bots)
- `TELEGRAM_ALLOWED_USERS` - IDs of Telegram users, that well be allowed te use this bot. You can get your ID from this [bot](https://t.me/my_id_bot)
- `POCKET_CONSUMER_KEY` - Pocket Consumer Key you can get by creating an app in Pocket. [Docs](https://getpocket.com/developer/)
- `POCKET_ACCESS_TOKEN` - access token you get using [Pocket Authentication API](https://getpocket.com/developer/docs/authentication)

You can automaticaly generate `POCKET_ACCESS_TOKEN` running

```bash
./scripts.sh run_generate -e
```

If you have nim compiler installed. Or you can run

```bash
docker-compose up -d
docker exec -it tg-to-pocket ./scripts.sh run_generate_build
docker-compose stop
```
After you followed all the instructions you will be provided with the line `POCKET_ACCESS_TOKEN=<token>` that you can put in `.env`

### Telegram webhook setup

After you get all up and runnig you should be able to send HTTP POST request to `http://<your_ip>:5000//tg/wh/<TELEGRAM_BOT_TOKEN>`. Telegram nowadays only send webhooks to HTTPS endpoints. So you need some kind of reverse proxy to setup HTTPS. I recommend using [Caddy](https://caddyserver.com/). Basic config in `Caddyfile` to get started:

```
{
    email <your email to sign ssl certificate>
}

<your domain> {
    reverse_proxy 0.0.0.0:5000
}
```
After Caddy is set up you shoud be able to use [setWebhook](https://core.telegram.org/bots/api#setwebhook) method of Telegram Bot API to setup incoming webhooks to your bot.

After you have done this, try to send link to your bot. It shoud appeare here [https://getpocket.com/saves](https://getpocket.com/saves)
