class Ingredient
  attr_reader :name, :quantity, :type, :measurement

  def initialize(name, type, quantity = '', measurement = '')
    @name = name
    @type = type
    @quantity = quantity
    @measurement = measurement
  end

  # returns a string in format of "3 cups of flour"
  def to_s
    if !measurement.empty?
      "#{quantity} #{measurement} of #{name}"
    else
      "#{quantity} #{name}"
    end
  end

  def ==(other)
    name == other.name &&
      type == other.type &&
      measurement == other.measurement
  end

  def valid?
    valid_name? && valid_type? && valid_quantity?
  end

  def valid_name?
    !name.empty?
  end

  def valid_type?
    !type.empty?
  end

  def valid_quantity?
    quantity.to_i > 0 
  end
end
