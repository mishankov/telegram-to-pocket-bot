FROM nimlang/nim

COPY ./src /src
COPY ./scripts.sh scripts.sh

RUN ./scripts.sh install && ./scripts.sh build

CMD build/tg-to-pocket

EXPOSE 5000