class GroceryList
  attr_accessor :list, :recipes

  def initialize
    @recipes = []
    @list = []
  end

  def can_generate?
    recipes.size >= 1
  end

  def generate!
    self.list = all_ingredients
    compress!
    sort!
    to_s
  end

  def has_recipes?
    !recipes.empty?
  end

  def has?(recipe)
    recipes.include?(recipe)
  end

  def add(list)
    recipes << list
  end

  def delete(recipe_name)
    recipes.delete_if {|recipe| recipe.name == recipe_name}
  end

  # removes all duplicate ingredients in @list
  # and compresses them into a single ingredient
  def compress!
    temp = all_ingredients
    result = []
    index = 0

    loop do
      ingredient = temp[index]
      duplicates = strip_duplicates(ingredient, temp)
      result << combine(duplicates)
      break if temp.empty?
    end

    self.list = result
  end

  def combine(ingredients)
    if ingredients.size > 1
      sum = ingredients.map(&:quantity).sum
      Ingredient.new(ingredients.first.name, ingredients.first.type, sum, ingredients.first.measurement)
    else
      ingredients.first
    end
  end

  # sorts ingredients based on type
  def sort!
    sorted = {}
    @list.each do |ingredient|
      sorted[ingredient.type] = [] unless sorted.key? ingredient.type
      sorted[ingredient.type] << ingredient
    end
    self.list = sorted.values.flatten
  end

  # returns array of ingredient objects from all of recipes
  def all_ingredients
    recipes.map(&:ingredients).flatten
  end

  # removes and returns duplicated ingredients
  # from an ingredient list
  def strip_duplicates(ingredient, ingredient_list)
    deleted = ingredient_list.select { |i| i == ingredient }
    ingredient_list.delete_if { |i| i == ingredient }
    deleted
  end

  # returns array of strings of the ingredients
  def to_s
    string = ''
    @list.map do |ingredient|
      string += ingredient.to_s
      string += "\n"
    end
    string
  end

end
