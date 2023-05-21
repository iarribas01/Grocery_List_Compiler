# REMEMBER THAT YOUR CACHE IS DISABLED

require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require 'sinatra/content_for'
require 'sinatra/contrib'

require_relative "./lib/ingredient"
require_relative "./lib/recipe"
require_relative "./lib/grocery_list"

@root = File.expand_path("..", __FILE__)
PATH_TO_RECIPES = @root + "/public/data/recipes/".freeze

before do
  session[:meals] = [] unless session[:meals]
  session[:grocery_list] = GroceryList.new unless session[:grocery_list]
end

configure do
  enable :sessions
  enable :method_override
  set :session_secret, SecureRandom.hex(32)
end

get "/" do
  erb :home
end

get "/new_recipe" do
  session[:recipe] = Recipe.new
  erb :new_recipe
end

get "/edit_meals" do
  @saved_recipes = Recipe.load_all
  erb :edit_meals
end

post "/add_meal" do
  @recipe = Recipe.load("#{params["selected_meal"]}.yaml")
  if session[:grocery_list].has?(@recipe)
    session[:error] = "#{@recipe.name} is already on the list."
    redirect "/edit_meals"
  else
    session[:grocery_list].add(@recipe)
    session[:success] = "#{@recipe.name} was added to this week's meals."
    @recipe = nil
    redirect "/edit_meals"
  end
end

post "/delete_meal" do
  session[:grocery_list].delete(params["delete"])
  session[:success] = "#{params["delete"]} was removed from the list."
  redirect "/edit_meals"
end

post "/generate" do
  if session[:grocery_list].can_generate?
    session[:grocery_list].generate!
    erb :grocery_list
  else
    session[:error] = "You must add at least one recipe."
    redirect "/edit_meals"
  end
end

post "/new_recipe" do
  session[:recipe].name = params["recipe_name"]
  session[:recipe].type = params["recipe_type"]

  if params["delete"]
    session[:recipe].delete(params["deleted_item"])
    erb :new_recipe

  elsif params["action"] == "Add ingredient"
    @ingredient = Ingredient.new(params["ingredient_name"], params["ingredient_type"], params["quantity"], params["measurement"])

    if @ingredient.valid?
      session[:recipe].add(@ingredient)
    else
      if !@ingredient.valid_name?
        session[:error] = "You must enter an ingredient name."
      elsif !@ingredient.valid_type?
        session[:error] = "You must enter an ingredient type."
      elsif !@ingredient.valid_quantity?
        session[:error] = "You must enter a quantity greater than or equal to 1."
      end
    end
    erb :new_recipe


  elsif params["action"] == "Add recipe"

    if session[:recipe].valid?
      session[:recipe].save
      session[:success] = "#{session[:recipe].name} was saved."
      session[:recipe] = nil
      redirect "/"
    else
      if session[:recipe].name.empty?
        session[:error] = "Your recipe must enter a name."
      elsif !session[:recipe].valid_name?
        session[:error] = "Your recipe name must be unique. #{session[:recipe].name} was already taken."
      elsif session[:recipe].type.empty?
        session[:error] = "Your recipe must enter a type."
      elsif !session[:recipe].has_ingredients?
        session[:error] = "Your recipe must enter at least one ingredient."
      end
    end

    erb :new_recipe
  end
end

