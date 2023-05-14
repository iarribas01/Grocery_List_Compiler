class Ingredient 
  def initialize(name, type, quantity="", measurement="")
    @name = name
    @type = type
    @quantity = quantity
    @measurement = measurement
  end

  # returns a string in format of "3 cups of flour"
  def to_s
    if measurement && !measurement.empty?
      quantity.to_s + " " + measurement + " of " + name
    else
      quantity.to_s + " " + name
    end 
  end

  def name
      @name
  end

  private

  def name=(new_name)
    @name = new_name
  end

  def type
    @type
  end

  def type=(new_type)
    @type = new_type
  end

  def quantity
    @quantity
  end

  def quantity=(new_quantity)
    @quantity = new_quantity
  end

  def measurement
    @measurement
  end

  def measurement=(new_measurement)
    @measurement = new_measurement
  end

end