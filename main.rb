require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require 'sinatra/content_for'

require_relative "./lib/ingredient"
require_relative "./lib/recipe"
require_relative "./lib/grocery_list"

@root = File.expand_path("..", __FILE__)

def get_filenames_from(directory)
  Dir.entries(directory).select { |f| File.file? File.join(directory, f) }
end

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
end

helpers do 
  def load_saved_recipes
    saved_recipes = []
    get_filenames_from("./public/data").each do |filename|
      saved_recipes << Recipe.load(filename)
    end
    saved_recipes
  end



end

get "/" do
  session[:grocery_list] = GroceryList.new
  erb :home
end

get "/new_recipe" do
  session[:recipe] = Recipe.new
  erb :new_recipe
end

get "/edit_meals" do
  erb :edit_meals
end

post "/new_recipe" do
  
  if params["action"] == "Add ingredient"
    new_ingredient = Ingredient.new(params["ingredient_name"], params["ingredient_type"], params["quantity"], params["measurement"])
    session[:recipe].add(new_ingredient)
    erb :new_recipe
  elsif params["action"] == "Add recipe"
    session[:grocery_list] = GroceryList.new
    session[:grocery_list].add(session[:recipe])
    # make sure to clear session
    p session[:grocery_list]
    redirect "/"
  end
end