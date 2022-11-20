install:
	nimble install jester -y

run-dev:
	scripts/run.sh

release:
	nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main

run-build: release
	scripts/run-build.sh

test:
	grep -v '^#' .env 