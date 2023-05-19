require 'yaml'
require_relative './ingredient'
require_relative '../main'

class Recipe
  attr_accessor :name, :type, :ingredients

  def initialize
    @name = ""
    @type = ""
    @ingredients = []
  end

  def has_ingredients?
    !ingredients.empty?
  end

  def add(ingredient)
    ingredients << ingredient
  end

  def id
    name.split.join('_')
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
end
