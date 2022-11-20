import httpClient, json

const telegramBaseUrl: string = "https://api.telegram.org/bot"

type
  Bot* = object
    token*: string


proc sendMessage*(bot: Bot, chatId: uint64, text: string, parseMode: string): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
    
  let 
    body = %*{"chat_id": chatId, "text": text, "parse_mode": parseMode}
    url = telegramBaseUrl & bot.token & "/sendMessage"

  let response = client.request(url, httpMethod = HttpPost, body = $body)
  
  return response.body
