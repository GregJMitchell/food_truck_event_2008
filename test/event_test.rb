require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
require './lib/event'

class EventTest <Minitest::Test
  def setup
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")

    #iteration 3 values
    @event1 = Event.new("South Pearl Street Farmers Market")

  end

  def test_it_exists
    assert_instance_of Event, @event
  end

  def test_it_has_readable_attributes
    assert_equal "South Pearl Street Farmers Market", @event.name
    assert_equal [], @event.food_trucks
  end

  def test_it_can_add_food_trucks
    @event.add_food_truck(@food_truck1)

    assert_equal [@food_truck1], @event.food_trucks
  end

  def test_it_can_find_truck_names
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @event.food_truck_names
  end

  def test_it_can_find_food_truck_that_sells_item
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)

    assert_equal [@food_truck1, @food_truck3], @event.food_trucks_that_sell(@item1)
    assert_equal [@food_truck2], @event.food_trucks_that_sell(@item4)
  end

  def test_it_can_find_total_inventory
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    @event1.add_food_truck(@food_truck1)
    @event1.add_food_truck(@food_truck2)
    @event1.add_food_truck(@food_truck3)

    expected = {
        @item1  => {
          quantity: 100,
          food_trucks: [@food_truck1, @food_truck3]
        },
        @item2 => {
          quantity: 7,
          food_trucks: [@food_truck1]
        },
        @item4 => {
          quantity: 50,
          food_trucks: [@food_truck2]
        },
        @item3 => {
          quantity: 35,
          food_trucks: [@food_truck2, @food_truck3]
        },
      }
      assert_equal expected, @event1.total_inventory
  end
end