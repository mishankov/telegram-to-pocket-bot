FROM nimlang/nim:1.6.8

COPY * /

RUN nimble release
CMD build/tg_to_pocket

EXPOSE 5000
