require 'yaml'

require_relative "ingredient.rb"
require_relative "recipe.rb"
require_relative "grocery_list.rb"

=begin
# Storing and retrieving ingredients in a hash


ingredient = {
  "onion" => "vegetable",
  "apple" => "fruit",
  "flour" => "baking"
}

File.open("./public/data/ingredients.yaml", "w") {|file| file.write(ingredient.to_yaml)}

ingredient = YAML.load(File.read("./public/data/ingredients.yaml"))
p ingredient

=end

#=================================================================================
recipes = [
  Recipe.load("chicken_curry.yaml"),
  Recipe.load("cereal_and_milk.yaml"),
  Recipe.load("mexican_soup.yaml")
]
grocery_list = GroceryList.new(recipes)
p grocery_list.ingredient_names(grocery_list.ingredients_from(grocery_list.recipes))



