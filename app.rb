require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'pry'

get '/webhook' do
  params['hub.challenge'] if ENV['VERIFY_TOKEN'] == params['hub.verify_token']
end

post '/webhook' do
  data = JSON.parse(request.body.read)
  sender_id = data['entry'].first['messaging'].first['sender']['id'].to_s
  message = data['entry'].first['messaging'].first['message']['text']
  message_json = '{ "recipient": { "id": "' + sender_id + '" }, "message": { "text": "' + message + '" } }'
  RestClient.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}", message_json, :content_type => :json)
end

get '/' do
  'Olá mundo! 2'
end
