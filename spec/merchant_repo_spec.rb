require 'CSV'
require 'RSpec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'

RSpec.describe MerchantRepo do
  before(:each) do
    @repo = SalesEngine.from_csv({:items => "./data/items.csv",
                                  :merchants => "./data/merchants.csv"})
  end

  describe 'instantiation' do
    it '::new' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)

      expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    it '#all' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)

      expect(merchant_repo.all).to be_an_instance_of(Array)
    end

    it '#can add a merchant' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)

      expect(merchant_repo.find_by_id(5)).to eq(nil)
      merchant_repo.add_merchant(merchant1)
      expect(merchant_repo.find_by_id(5)).to eq(merchant1)
    end

    it '#find merchant by ID' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)
      merchant_repo.add_merchant(merchant1)

      expect(merchant_repo.find_by_id(5)).to eq(merchant1)
      expect(merchant_repo.find_by_id(999999999)).to eq(nil)
    end

    it '#find merchant by name' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)
      merchant_repo.add_merchant(merchant1)

      expect(merchant_repo.find_by_name("Turing School")).to eq(merchant1)
      expect(merchant_repo.find_by_name("Hogwarts School")).to eq(nil)
    end

    it '#find all merchants by name' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)
      merchant_repo.add_merchant(merchant1)

      expect(merchant_repo.find_by_name("Turing School")).to eq(merchant1)
      expect(merchant_repo.find_all_by_name("Hogwar")).to eq([])
    end

    it '#create merchant' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
     
      merchant_info = {:id => 5, :name => "Turing School"}

      expect(merchant_repo.create(merchant_info)).to be_an_instance_of(Merchant)
    end

    it '#updates attributes' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)
      merchant_repo.add_merchant(merchant1)

      updated_attributes = {:name => "School of Life"}

      merchant_repo.update(5, updated_attributes)
      expect(merchant1.name).to eq("School of Life")
    end

    it '#delete merchant' do
      merchant_repo = MerchantRepo.new('./data/merchants.csv', @repo)
      merchant1 = Merchant.new({:id => 5, :name => "Turing School"}, @repo)
      merchant_repo.add_merchant(merchant1)

      expect(merchant_repo.find_by_id(5)).to eq(merchant1)
      merchant_repo.delete(5)
      expect(merchant_repo.find_by_id(5)).to eq(nil)
    end
  end
end
