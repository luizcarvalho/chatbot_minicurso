require 'sinatra'
require 'sinatra/reloader'


VERIFY_TOKEN = 'VERIFY_TOKEN_EXTREMAMENTE_SECRETO'


get '/webhook' do
  params['hub.challenge'] if VERIFY_TOKEN == params['hub.verify_token']
end

post '/webhook' do
  puts JSON.parse(request.body.read)
end


get '/' do
  'Olá mundo! 2'
end