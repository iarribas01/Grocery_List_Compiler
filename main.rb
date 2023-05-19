require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require 'sinatra/content_for'

require_relative "./lib/ingredient"
require_relative "./lib/recipe"
require_relative "./lib/grocery_list"

@root = File.expand_path("..", __FILE__)
PATH_TO_RECIPES = @root + "/public/data/recipes/"

before do
  session[:meals] = [] unless session[:meals]
  session[:grocery_list] = GroceryList.new unless session[:grocery_list]
end

configure do
  enable :sessions
  enable :method_override
  set :session_secret, SecureRandom.hex(32)
end

post "/add_meal" do
  
  recipe = load(params["selected_meal"])
  session[:grocery_list].add(recipe)
  redirect "/edit_meals"
end

post "/delete_meal" do
  session[:grocery_list].delete(params["delete"])
  redirect "/edit_meals"
end


get "/" do
  erb :home
end

get "/new_recipe" do
  session[:recipe] = Recipe.new
  erb :new_recipe
end

get "/edit_meals" do
  @saved_recipes = load_saved_recipes
  erb :edit_meals
end

post "/generate" do
  session[:grocery_list].generate!
  erb :grocery_list
end

post "/new_recipe" do
  if params["action"] == "Add ingredient"
    new_ingredient = Ingredient.new(params["ingredient_name"], params["ingredient_type"], params["quantity"], params["measurement"])
    session[:recipe].add(new_ingredient)
    erb :new_recipe
  elsif params["action"] == "Add recipe"
    session[:recipe].save
    session.delete(:recipe)
    redirect "/"
  end
end

# ============ HELPER METHODS ============
def get_filenames_from(directory)
  Dir.entries(directory).select { |f| File.file? File.join(directory, f) }
end

def load_saved_recipes
  saved_recipes = []
  get_filenames_from(PATH_TO_RECIPES).each do |filename|
    saved_recipes << Recipe.load(filename)
  end
  saved_recipes
end


def load(recipe_id)
  Recipe.load("#{recipe_id}.yaml")
end

