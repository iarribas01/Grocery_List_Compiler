require 'yaml'
require_relative './ingredient'

class Recipe
  DATA_PATH = './public/data'.freeze

  attr_reader :name, :type, :ingredients

  def initialize(name, type, ingredients)
    @name = name
    @type = type
    @ingredients = ingredients
  end

  # store Recipe object in YAML file
  def save(filename = '')
    filename = File.join(DATA_PATH, "#{@name.split.join('_')}.yaml") if filename.empty?
    File.open(filename, 'w') { |file| file.write(to_yaml) }
  end

  # retrieve Recipe object from YAML file
  def self.load(filename)
    YAML.load_file(File.join(DATA_PATH, filename), permitted_classes: [Recipe, Ingredient])
  end
end
