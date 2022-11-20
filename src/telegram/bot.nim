import httpClient, json

const telegramBaseUrl: string = "https://api.telegram.org/bot"

proc sendMessage*(botToken: string, chatId: uint64, text: string, parseMode: string): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
    
  let 
    body = %*{"chat_id": chatId, "text": text, "parse_mode": parseMode}
    url = telegramBaseUrl & botToken & "/sendMessage"

  let response = client.request(url, httpMethod = HttpPost, body = $body)
  
  return response.body
