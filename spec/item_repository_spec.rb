require 'CSV'
require 'RSpec'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
# require './data/merchants.csv'

RSpec.describe ItemRepo do
  describe 'instantiation' do

    it '::new' do
      ir = ItemRepo.new

    expect(ir).to be_an_instance_of(ItemRepo)
    end

    it 'has attributes' do
      ir = ItemRepo.new

      expect(ir.items).to eq ([])
    end
  end

  describe '#methods' do
    it '#populates information' do
      ir = ItemRepo.new

      expect(ir.populate_information).to be_an_instance_of(Hash)
    end

    it '#all' do
      ir = ItemRepo.new

      expect(ir.all).to be_an_instance_of(Array)
    end

    it '#find by id' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_by_id(1)).to eq(i)
      expect(ir.find_by_id(45)).to eq(nil)
    end

    it '#find by name' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_by_name("Pencil")).to eq(i)
      expect(ir.find_by_name("not exist")).to eq(nil)
    end

    it '#find by description' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_all_with_description("You can use it to write things")).to eq([i])
      expect(ir.find_all_with_description("not exist")).to eq([])
    end

    it '#find by price' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_all_by_price(10.99)).to eq([i])
      expect(ir.find_all_by_price(0)).to eq([])
    end

    it '#find by price' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_all_by_price_in_range(10.97..10.99)).to eq([i])
      expect(ir.find_all_by_price_in_range(0..0.1)).to eq([])
    end

    it '#find by price' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_all_by_price_in_range(10.97..10.99)).to eq([i])
      expect(ir.find_all_by_price_in_range(0..0.1)).to eq([])
    end

    it '#find by merchant' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)

      expect(ir.find_all_by_merchant_id(2)).to eq([i])
      expect(ir.find_all_by_merchant_id(0)).to eq([])
    end

    it '#creates item' do
      ir = ItemRepo.new
      item_info = {:id          => 0,
                    :name        => nil,
                    :description => nil,
                    :unit_price  => BigDecimal(0),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 0
                  }

      ir.populate_information
      ir.all

      expect(ir.create(item_info)).to be_an_instance_of(Item)
    end

    xit '#update attributes' do
      ir = ItemRepo.new
      i = Item.new({:id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    :merchant_id => 2
                  })
      ir.add_item(i)
      updated_attributes = {:name => "knife",
                            :description => "You can use it to stab things",
                            :unit_price  => BigDecimal(15.99,4),
                            :updated_at  => Time.now,
                          }
      ir.update(1, updated_attributes)

      expect(i.id).to eq(1)
      expect(i.name).to eq("knife")
      expect(i.description).to eq("You can use it to stab things")
      expect(i.unit_price).to eq(15.99,4)
      expect(i.updated_at).to be_an_instance_of(Time)
    end
  end
end