import httpClient, json

proc addBookmark*(consumerKey: string, accessToken: string, content: string): string =
    let 
        client = newHttpClient()
        url = "https://getpocket.com/v3/add"
        body = %*{"url": content, "consumer_key": consumerKey, "access_token": accessToken}

    client.headers = newHttpHeaders({ "Content-Type": "application/json" })
    let response = client.request(url, httpMethod = HttpPost, body = $body)

    return response.body
