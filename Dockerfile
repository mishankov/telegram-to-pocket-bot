FROM nimlang/nim:1.6.8

COPY ./src /src
COPY ./scripts.sh scripts.sh

RUN ./scripts.sh install && ./scripts.sh build

CMD build/tg-to-pocket

EXPOSE 5000