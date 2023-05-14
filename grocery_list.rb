class GroceryList
  def initialize(recipes, list = [])
    @recipes = recipes
    @list = list
  end

  def list
    @list
  end

  # returns array of ingredients from list of recipes
  def ingredients_from(recipes)
    recipes.map do |recipe|
      recipe.ingredients
    end.flatten
  end

  # returns an array of strings containing the unique
  # ingredients from all of the recipes
  def ingredient_names(ingredients)
    ingredients.map do |ingredient|
      ingredient.name
    end.uniq
  end

  def recipes
    @recipes
  end

  private
  
  def list=(new_list)
    @list = new_list
  end


  # returns an array of ingredients where 
  # overlap between recipes is compressed
    # ex) two recipes call for 1 onion,
    #     list -> 2 onions

  def compress()
    # cycle through list of ingredient names
    # if the count of a particular ingredient name is more than one
      # find the two ingredients in the list of ingredients
      # compress them
        # add the two quantities
        # delete the duplicate instances of ingredients and keep one
    # otherwise
      # continue until reached the end of the ingredient names

  end

  def sort()

  end

  # returns hash of name and quantity of ingredients
  def simplify()

  end

end