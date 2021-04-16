require 'bigdecimal'
require 'CSV'
require 'time'
require 'item'

class ItemRepo
  attr_reader :items
  def initialize(path, engine)
    @items = []
    @engine = engine
    populate_information(path)
   
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |item_info|
      @items << Item.new(item_info, @engine)
    end
  end

  def all
   @items
  end

  def add_item(item)
    @items << item
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
    (range).include?(item.unit_price)
    end
  end

  # This method needs to be refactored
  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    item = Item.new(attributes, @engine)
    max = @items.max_by do |item|
      item.id
    end
    item.id = max.id + 1
    add_item(item)
    return item
  end
  
  # the code logic doesn't belong here, what happens when only one gets updated 
  def update(id, attributes)
    new_item = find_by_id(id)
    # new_item.assign_attributes(attributes)

    #   attributes.each do |key, value|
    #     if new_item.(key) = value 
    #   end
    new_item.name = attributes[:name]
    new_item.description = attributes[:description]
    new_item.unit_price = attributes[:unit_price]
    new_item.updated_at = attributes[:updated_at]
    return new_item
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end
end