require 'bigdecimal'

class Item
  attr_reader :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :repo

  def initialize(item_info, repo)
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = BigDecimal((item_info[:unit_price].to_i / 100.to_f), 8)
    @created_at = Time.parse(item_info[:created_at].to_s)
    @updated_at = Time.parse(item_info[:updated_at].to_s)
    @merchant_id = item_info[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_all(attributes)
    update_name(attributes)
    update_description(attributes)
    update_unit_price(attributes)
    update_updated_at(attributes)
  end

  def update_name(attributes)
    @name = attributes[:name] if attributes[:name]
  end

  def update_description(attributes)
    @description = attributes[:description] if attributes[:description]
  end

  def update_unit_price(attributes)
    @unit_price = attributes[:unit_price] if attributes[:unit_price]
  end

  def update_updated_at(attributes)
    @updated_at = attributes[:updated_at] if attributes[:updated_at]
  end

  def update_id(new_id)
    @id = new_id + 1
  end
end
