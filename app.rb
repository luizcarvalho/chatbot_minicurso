require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'pry'

get '/webhook' do
  params['hub.challenge'] if ENV['VERIFY_TOKEN'] == params['hub.verify_token']
end

post '/webhook' do
  puts JSON.parse(request.body.read)
  message_json = '{ "recipient": { "id": "1389611254450074" }, "message": { "text": "hello, world!" } }'
  RestClient.post("https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_ACCESS_TOKEN']}", message_json, :content_type => :json)
end

get '/' do
  'Olá mundo! 2'
end
