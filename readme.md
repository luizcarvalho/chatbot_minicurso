MINICURSO CHATBOT UNITINS
===================


Primeiramente a máquina deve estar configurada com ruby, pode utilizar esse tutorial para isso https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-16-04.

----------


Simple Ruby Chatbot
-------------

```
gem install sinatra
```

crie o arquivo app.rb e abra em seu editor
```
subl app.rb
```
Escreva o seguinte código
```
require 'sinatra'

get '/' do
  'ok'
end
```
rode

```
ruby app.rb
```

Altere o código para
```
require 'sinatra'

get '/' do
  'hello word'
end
```
Vamos  facilitar nossa vida
```
$ gem install sinatra-contrib

# adicione em seu app.rb
require 'sinatra/reloader'

```

### Criando um app do Facebook

- Acesse https://developers.facebook.com/apps/
- Adicionar um novo aplicativo
- Crie um número de identificação do aplicativo
- Messenger -> Configurar
- Geração de token
- Copie o token

Para externalizar o servidor

- Baixe o [ngrok](https://ngrok.com/download)

```
./ngrok http 4567
```

- Setup Webhooks
- Cole a URL do ngrok (https)
- Crie um verify token
- Marque messages e messages postback
- altere seu app.rb

```
require 'sinatra'
require 'sinatra/reloader'

VERIFY_TOKEN = 'VERIFY_TOKEN_EXTREMAMENTE_SECRETO'


get '/webhook' do
  params['hub.challenge'] if VERIFY_TOKEN == params['hub.verify_token']
end


get '/' do
  'Olá mundo!'
end
```

#Voilà

- Vá para [m.me](http://m.me)

```
post '/webhook' do
end
```

- Agora vamos responder essas mensagens, acesse: https://developers.facebook.com/docs/messenger-platform/reference/send-api

- Envie uma mensagem e acesse http://127.0.0.1:4040/inspect/http
- pegar sender id
- enviar via curl como na documentação


## Melhorando nosso código



```
export VERIFY_TOKEN=VERIFY_TOKEN_EXTREMAMENTE_SECRETO
export ACCESS_TOKEN=TOKEN_DA_PAGINA
export APP_SECRET=CHAVE_SECRETA_APPLICATION
```



```
$ gem isntall rest-client
```

```
require 'rest-client'
# (...)

# Substitua o recipient id pelo seu
post '/webhook' do
  puts JSON.parse(request.body.read)
  # Substitua o recipient id pelo seu (http://127.0.0.1:4040/inspect/http)
  message_json = '{ "recipient": { "id": "1389611254450074" }, "message": { "text": "hello, world!" } }'
  RestClient.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['ACCESS_TOKEN']}", message_json, :content_type => :json)
end

```


# Adicionando capacidade de resposta
Pegue as informações em: http://127.0.0.1:4040/inspect/http

```
post '/webhook' do
  data = JSON.parse(request.body.read)

  sender_id = data['entry'].first['messaging'].first['sender']['id'].to_s
  message = data['entry'].first['messaging'].first['message']['text']

  message_json = '{ "recipient": { "id": "' + sender_id + '" }, "message": { "text": "' + message + '" } }'

  RestClient.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}", message_json, :content_type => :json)
end
```


# Usando a Gem facebook-messenger


instala Gem Facebook-Messenger

```
$ gem install facebook-messenger
```

Crie o arquivo config.ru e digite as seguintes instruções

```
require './app'

require 'facebook/messenger'

map('/webhook') do
  run Sinatra::Application
  run Facebook::Messenger::Server
end

# run regular sinatra for other paths (in case you ever need it)
run Sinatra::Application

```

Em seu app.rb

```
require 'sinatra'
require 'sinatra/reloader'
require 'facebook/messenger'

include Facebook::Messenger
puts Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  message.reply(text: message.text)
end
```

# Adicionando funcionalidades ao Chatbot

Instale a gem do Wikipedia
```
$ gem install wikipedia-client
```

Em seu app.rb
```
require 'wikipedia'
# (...)
Bot.on :message do |message|
  page = Wikipedia.find(message.text)
  if page.text
    message.reply(text: "#{page.text.slice(0, 150)}... \b link completo: #{page.fullurl}")
  else
    message.reply("Infelizmente não consegui encontrar a definição para #{message.text}")
  end
end
```

