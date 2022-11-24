FROM nimlang/nim:1.6.8

COPY ./src /src
COPY ./telegram_to_pocket_bot.nimble telegram_to_pocket_bot.nimble

RUN nimble release
CMD build/tg_to_pocket

EXPOSE 5000
