# run with rackup
require 'sinatra'
require 'sinatra/reloader'
require 'facebook/messenger'
require 'wikipedia'

include Facebook::Messenger
puts Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  page = Wikipedia.find(message.text)
  if page.text
    message.reply(text: "#{page.text.slice(0, 150)}... \b link completo: #{page.fullurl}")
  else
    message.reply("Infelizmente não consegui encontrar a definição para #{message.text}")
  end
end
