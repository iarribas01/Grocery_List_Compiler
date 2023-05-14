require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require 'sinatra/content_for'

require_relative "./ingredient.rb"
require_relative "./recipe.rb"

@root = File.expand_path("..", __FILE__)

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
end

get "/" do 
  erb :home
end

get "/meal" do
  erb :meal
end