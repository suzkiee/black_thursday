require 'CSV'

class SalesEngine
  attr_reader :item,
              :merchant
  def initialize(sales_info)
    @item = ItemsRepo.new(sales_info[:items], self)
    @merchant = MerchantRepo.new(sales_info[:merchants], self)
  end

  # def self.from_csv(sales_info)
  #   items = sales_info[:items]
  #   merchants = sales_info[:merchants]
  #   CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
  #     id = row[:id].to_i
  #     name = row[:name]
  #     description = row[:description]
  #     unit_price = nil
  #     # created_at =
  #     # updated_at =
  #     # merchant_id =
  #     item_info = {:id => id,
  #                  :name => name,
  #                  :description => description,
  #                  :unit_price => unit_price,
  #                  :created_at => nil,
  #                  :updated_at => nil,
  #                  :merchant_id => nil
  #                }
  #
  #     item = Item.new(item_info)
  #     puts "#{item.name} has been created!"
  #   end
end