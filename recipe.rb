require 'yaml'
require_relative "./ingredient.rb"

class Recipe

  DATA_PATH = "./public/data"

  def initialize(name, type, ingredients)
    @name = name
    @type = type
    @ingredients = ingredients
  end

  def name
    @name
  end

  def type
    @type
  end

  def ingredients
    @ingredients
  end

  # store Recipe object in YAML file
  def save(filename="")
    if filename.empty?
      filename = File.join(DATA_PATH, @name.split.join("_") + ".yaml")
    end
    File.open(filename, "w") {|file| file.write(self.to_yaml)}
  end

  # retrieve Recipe object from YAML file
  def self.load(filename)
    YAML.load_file(File.join(DATA_PATH, filename), permitted_classes: [Recipe, Ingredient])
  end

  private

end