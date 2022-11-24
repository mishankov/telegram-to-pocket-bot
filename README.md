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
mv config.template.toml config.toml
```
Then edit `config.toml` file with folowing variables:

- `telegramBotToken` - Telegram Bbot token provided by BotFather. [Docs](https://core.telegram.org/bots)
- `telegramAllowedUsers` - IDs of Telegram users, that well be allowed te use this bot. You can get your ID from this [bot](https://t.me/my_id_bot)
- `pocketConsumerKey` - Pocket Consumer Key you can get by creating an app in Pocket. [Docs](https://getpocket.com/developer/)
- `pocketAccessToken` - access token you get using [Pocket Authentication API](https://getpocket.com/developer/docs/authentication)

Then run container

```bash
docker-compose up -d
```

You can automaticaly generate `pocketAccessToken` running

```bash
./build/generate_token
```

If you have nim compiler installed. Or you can run

```bash
docker exec -it tg-to-pocket ./build/generate_token
```
After you followed all the instructions you will be provided with the line `pocketAccessToken = <token>` that you can put in `config.toml`

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

After you have done this, try to send link to your bot. It should appear here [https://getpocket.com/saves](https://getpocket.com/saves)
