#! /bin/bash

install_deps() {
    echo "Install deps"
    nimble install jester@0.5.0 -y
}

build() {
    echo "Build tg-to-pocket and generate_token"
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg-to-pocket src/main
    nim c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/generate_token src/generate_token
}


command="$1"
echo "Executing command ${command}"

use_env_file="$2"
if [[ ${use_env_file} == "-e" ]]; then
    echo "Loading variables from .env file"
    export $(grep -v '^#' .env | xargs -d '\n')
fi


if [[ ${command} == "build" ]]; then
    build

elif [[ ${command} == "ci_build" ]]; then
    install_deps
    build

elif [[ ${command} == "install" ]]; then
    install_deps


elif [[ ${command} == "run_build" ]]; then
    build/tg-to-pocket

elif [[ ${command} == "run" ]]; then
    nim c -d:ssl -d:useOpenssl3 -f:on -o:build/tg-to-pocket -r src/main


elif [[ ${command} == "run_generate_build" ]]; then
    build/generate_token

elif [[ ${command} == "run_generate" ]]; then
    nim c -d:ssl -d:useOpenssl3 -f:on -o:build/generate_token -r src/generate_token


else
    echo "No command named ${command}"
    echo "Available commands: "
    echo "  build               - create optimized build"
    echo "  ci_build            - create build for CI"
    echo "  install             - install dependencies"
    echo "  run_build           - run optimized build"
    echo "  run                 - run for development"
    echo "  run_generate_build  - run generate token optimized build"
    echo "  run_generate        - run generate token for development"

    exit 1
fi
