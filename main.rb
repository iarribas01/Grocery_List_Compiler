require 'sinatra'
require 'sinatra/reloader'

root = File.expand_path("..", __FILE__)

get "/" do 
  erb :home
end