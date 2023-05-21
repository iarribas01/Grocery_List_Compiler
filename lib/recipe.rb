require 'yaml'
require_relative './ingredient'
require_relative '../main'

class Recipe
  attr_accessor :name, :type, :ingredients

  def initialize(name="", type="")
    @name = name
    @type = type
    @ingredients = []
  end

  def has_ingredients?
    !ingredients.empty?
  end

  def add(ingredient)
    ingredients << ingredient
  end

  def delete(ingredient_name)
    ingredients.delete_if{|i| i.name == ingredient_name}
  end

  def id
    name.split.join('_')
  end

  def ==(other)
    name == other.name
  end

  # store Recipe object in YAML file
  def save(filename = '')
    filename = File.join(PATH_TO_RECIPES, "#{id}.yaml") if filename.empty?
    File.open(filename, 'w') { |file| file.write(to_yaml) }
  end

  # retrieve Recipe object from YAML file
  def self.load(filename)
    YAML.load_file(File.join(PATH_TO_RECIPES, filename), permitted_classes: [Recipe, Ingredient])
  end

  def self.get_recipe_filenames
    Dir.entries(PATH_TO_RECIPES).select { |f| File.file? File.join(PATH_TO_RECIPES, f) }
  end

  def self.load_all
    saved = []
    get_recipe_filenames.each do |filename|
      saved << Recipe.load(filename)
    end
    saved
  end

  def valid?
    (!name.empty? && valid_name? && !type.empty? && has_ingredients?)
  end

  def valid_name?
    Recipe.get_recipe_filenames.map{|f| File.basename(f)}.include?(id) ? false : true
  end
end
