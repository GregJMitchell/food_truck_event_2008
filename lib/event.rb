class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |food_truck| food_truck.name}
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all { |food_truck| food_truck.inventory.include? item }
  end

  def find_items
    items = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item|
        items << item unless items.include? item
      end
    end
    items
  end

  def total_inventory
    total = {}
    find_items.each do |item|
      item_hash = {}
      if total.keys.include? item
        item_hash[:quantity] = item_hash[:quantity] + item[1]
        item_hash[:food_trucks] = food_trucks_that_sell(item[0])
        total[item] = item_hash
      else
        item_hash[:quantity] = item[1]
        item_hash[:food_trucks] = food_trucks_that_sell(item[0])
        total[item] = item_hash
      end
    end
    total
  end
end