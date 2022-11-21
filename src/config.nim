from os import getEnv

proc telegramBotToken*(): string = return getEnv("TELEGRAM_BOT_TOKEN", "none")
proc telegramAllowedUsers*(): string = return getEnv("TELEGRAM_ALLOWED_USERS", "none")
proc pocketConsumerKey*(): string = return getEnv("POCKET_CONSUMER_KEY", "none")
proc pocketAccessToken*(): string = return getEnv("POCKET_ACCESS_TOKEN", "none")