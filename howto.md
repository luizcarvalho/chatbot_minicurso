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
require 'pry'

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


```
post '/webhook' do
  puts params
end
```
