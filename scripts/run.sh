export $(grep -v '^#' .env | xargs -d '\n') && nim c -d:ssl -d:useOpenssl3 -f:on -o:build/tg-to-pocket -r src/main
