require 'sinatra'
require 'sinatra/reloader'
require 'pry'

VERIFY_TOKEN = 'VERIFY_TOKEN_EXTREMAMENTE_SECRETO'


get '/webhook' do
  params['hub.challenge'] if VERIFY_TOKEN == params['hub.verify_token']
end

post '/webhook' do
  puts params
end


get '/' do
  'Olá mundo! 2'
end