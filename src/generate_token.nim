from pocket import obtainRequestToken, obtainAccessToken
import config

if isMainModule:
    const redirectUrl = "https://google.com"
    let requestToken = obtainRequestToken(consumerKey = config.pocketConsumerKey(), redirectUrl = redirectUrl)

    echo "Obtained request token: " & requestToken
    echo "Visit link:"
    echo "https://getpocket.com/auth/authorize?request_token=" & requestToken & "&redirect_uri=" & redirectUrl
    echo "Press Enter after confirm"
    discard readLine(stdin)

    let tokenResponse = obtainAccessToken(config.pocketConsumerKey(), requestToken)
    echo "Successfuly obtained token for user " & tokenResponse.username
    echo "POCKET_ACCESS_TOKEN=" & tokenResponse.access_token