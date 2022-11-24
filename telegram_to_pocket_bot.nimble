# Package

version       = "0.1.0"
author        = "Denis Mishankov"
description   = "Telegram Bot to save links to Pocket"
license       = "MIT"
srcDir        = "src"
binDir        = "build"
bin           = @["tg_to_pocket", "generate_token"]


# Dependencies

requires "nim >= 1.6.8", "jester == 0.5.0", "parsetoml == 0.6.0" 


# Tasks

task release, "Build tg_to_pocket and generate_token":
    exec "nimble c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/tg_to_pocket src/tg_to_pocket -y"
    exec "nimble c -d:ssl -d:useOpenssl3 -d:release -f:on -o:build/generate_token src/generate_token -y"

task run_bot, "Run bot for test":
    exec "nimble run -d:ssl -d:useOpenssl3 -f:on tg_to_pocket"

task run_generate, "Run Pocket token generator":
    exec "nimble run -d:ssl -d:useOpenssl3 -f:on generate_token"
