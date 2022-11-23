from pocket import obtainRequestToken, obtainAccessToken
from config import loadConfig, Config

if isMainModule:
    const redirectUrl = "https://google.com"
    let config = loadConfig()
    let requestToken = obtainRequestToken(consumerKey = config.pocketConsumerKey, redirectUrl = redirectUrl)

    echo "Obtained request token: " & requestToken
    echo "Visit link:"
    echo "https://getpocket.com/auth/authorize?request_token=" & requestToken & "&redirect_uri=" & redirectUrl
    echo "Press Enter after confirm"
    discard readLine(stdin)

    let tokenResponse = obtainAccessToken(config.pocketConsumerKey, requestToken)
    echo "Successfuly obtained token for user " & tokenResponse.username
    echo "pocketAccessToken = " & tokenResponse.access_token
