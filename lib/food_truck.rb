class FoodTruck
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    return 0 if @inventory.keys.include?(item) == false
    @inventory[item]
  end

  def stock(item, amount)
    @inventory[item] = amount
  end

  def potential_revenue
    @inventory.sum { |item, amount| item.price * amount }
  end
end