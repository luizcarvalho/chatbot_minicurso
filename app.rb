# run with rackup
require 'sinatra'
require 'sinatra/reloader'
require 'facebook/messenger'

include Facebook::Messenger
puts Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  message.reply(text: message.text)
end
