nimble install jester -y
nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main
