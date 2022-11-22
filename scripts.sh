#! /bin/bash

command="$1"
echo "Executing command ${command}"

if [[ ${command} == "build" ]]; then
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main

elif [[ ${command} == "ci_build" ]]; then
    nimble install jester -y
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main

elif [[ ${command} == "install" ]]; then
    nimble install jester -y

elif [[ ${command} == "run_build" ]]; then
    export $(grep -v '^#' .env | xargs -d '\n')
    build/tg-to-pocket

elif [[ ${command} == "run" ]]; then
    . .env
    nim c -d:ssl -d:useOpenssl3 -f:on -o:build/tg-to-pocket -r src/main


else
    echo "No command named ${command}"
    echo "Available commands: "
    echo "  build       - create optimized build"
    echo "  ci_build    - create build for CI"
    echo "  install     - install dependencies"
    echo "  run_build   - run optimized build"
    echo "  run         - run for development"

fi
