FROM nimlang/nim

COPY ./src /src

RUN nimble install jester -y 

RUN nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main

CMD build/tg-to-pocket

EXPOSE 5000