import httpClient, json, strutils

proc addBookmark*(consumerKey: string, accessToken: string, content: string): string =
    let 
        client = newHttpClient()
        url = "https://getpocket.com/v3/add"
        body = %*{"url": content, "consumer_key": consumerKey, "access_token": accessToken}

    client.headers = newHttpHeaders({ "Content-Type": "application/json" })

    let response = client.request(url, httpMethod = HttpPost, body = $body)
    client.close()

    return response.body


proc obtainRequestToken*(consumerKey: string, redirectUrl: string): string =
    let
        client = newHttpClient()
        url = "https://getpocket.com/v3/oauth/request"
        body = %*{"consumer_key": consumerKey, "redirect_uri": redirectUrl}
    
    client.headers = newHttpHeaders({ "Content-Type": "application/json" })

    let response = client.request(url, httpMethod = HttpPost, body = $body)
    client.close()

    let code = $(response.body).split("=")[1]

    return code

type 
    AccessTokenResponse* = object
        access_token*: string
        username*: string

proc obtainAccessToken*(consumerKey: string, code: string): AccessTokenResponse =
    let
        client = newHttpClient()
        url = "https://getpocket.com/v3/oauth/authorize"
        body = %*{"consumer_key": consumerKey, "code": code}
    
    client.headers = newHttpHeaders({ "Content-Type": "application/json", "X-Accept": "application/json" })
    
    let response = client.request(url, httpMethod = HttpPost, body = $body)
    client.close()

    let payloadJson = parseJson(response.body)
    let payload = to(payloadJson, AccessTokenResponse)

    return payload
