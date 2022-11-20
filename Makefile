install:
	nimble install jester -y

run:
	nim c -d:ssl -d:useOpenssl3 -f:on -o:build/tg-to-pocket -r src/main

release:
	nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main
