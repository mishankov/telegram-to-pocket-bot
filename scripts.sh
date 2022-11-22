#! /bin/bash

command="$1"
echo "Executing command ${command}"

if [[ ${command} == "build" ]]; then
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/generate_token src/generate_token

elif [[ ${command} == "ci_build" ]]; then
    nimble install jester -y
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/generate_token src/generate_token

elif [[ ${command} == "install" ]]; then
    nimble install jester -y


elif [[ ${command} == "run_build" ]]; then
    export $(grep -v '^#' .env | xargs -d '\n')
    build/tg-to-pocket

elif [[ ${command} == "run" ]]; then
    export $(grep -v '^#' .env | xargs -d '\n')
    nim c -d:ssl -d:useOpenssl3 -f:on -o:build/tg-to-pocket -r src/main


elif [[ ${command} == "run_generate_build" ]]; then
    export $(grep -v '^#' .env | xargs -d '\n')
    build/generate_token

elif [[ ${command} == "run_generate" ]]; then
    export $(grep -v '^#' .env | xargs -d '\n')
    nim c -d:ssl -d:useOpenssl3 -f:on -o:build/generate_token -r src/generate_token


else
    echo "No command named ${command}"
    echo "Available commands: "
    echo "  build               - create optimized build"
    echo "  ci_build            - create build for CI"
    echo "  install             - install dependencies"
    echo "  run_build           - run optimized build"
    echo "  run                 - run for development"
    echo "  run_generate_build  - run for development"
    echo "  run_generate        - run generate token for development"
fi
