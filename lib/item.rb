class Item
  attr_reader :name, :price
  def initialize(data_hash)
    @name = data_hash[:name]
    @price = convert_price_to_integer(data_hash[:price])
  end

  def convert_price_to_integer(price)
    price.gsub(/[$]/, '').to_f
  end
end