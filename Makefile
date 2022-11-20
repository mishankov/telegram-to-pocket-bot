install:
	nimble install jester -y

run:
	nim c -d:ssl -f:on -o:build/main -r src/main
