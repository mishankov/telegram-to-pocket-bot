from os import getEnv

const
    TELEGRAM_BOT_TOKEN* = getEnv("TELEGRAM_BOT_TOKEN", "none")
    TELEGRAM_ALLOWED_USERS* = getEnv("TELEGRAM_ALLOWED_USERS", "none")
    POCKET_CONSUMER_KEY* = getEnv("POCKET_CONSUMER_KEY", "none")
    POCKET_ACCESS_TOKEN* = getEnv("POCKET_ACCESS_TOKEN", "none")
