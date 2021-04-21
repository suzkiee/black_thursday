require 'CSV'
require 'sales_engine'
require 'merchant'

RSpec.describe MerchantRepo do
  describe 'instantiation' do
    xit'::new' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    xit '#all' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)

      expect(merchant_repo.all).to be_an_instance_of(Array)
    end

    xit '#find merchant by ID' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})


      expect(merchant_repo.find_by_id(merchant.id, collection)).to eq(merchant)
      expect(merchant_repo.find_by_id(999999999, collection)).to eq(nil)
    end

    xit '#find merchant by name' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                     :name => "Turing School"})

      expect(merchant_repo.find_by_name("Turing School", collection)).to eq(merchant)
      expect(merchant_repo.find_by_name("Hogwarts School", collection)).to eq(nil)
    end

    xit '#find all merchants by name' do #FIX THIS!!!
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      collection = merchant_repo.merchants
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})
    #******************to check on, Wed, 21st a.m.********************
      expect(merchant_repo.find_by_name("Turing Scho", collection)).to eq(merchant)
      expect(merchant_repo.find_all_by_name("Hogwar", collection)).to eq([])
    end

    xit '#create merchant' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      merchant_info = {:id => 5,
                       :name => "Turing School"}

      expect(merchant_repo.create(merchant_info)).to be_an_instance_of(Merchant)
    end

    xit '#updates attributes' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})

      updated_attributes = {:name => "School of Life"}

      merchant_repo.update(merchant.id, updated_attributes)
      expect(merchant.name).to eq("School of Life")
    end

    xit '#delete merchant' do
      mock_engine = double('MerchantRepo')
      merchant_repo = MerchantRepo.new('./fixtures/mock_items.csv', mock_engine)
      merchant = merchant_repo.create({:id => 5,
                                       :name => "Turing School"})

      expect(merchant_repo.find_by_id(merchant.id)).to eq(merchant)
      merchant_repo.delete(merchant.id)
      expect(merchant_repo.find_by_id(merchant.id)).to eq(nil)
    end
  end

  describe '#salesanalyst' do
    it '#item count' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                          :merchants => './fixtures/mock_merchants.csv',
                                          :invoices => './fixtures/mock_invoices.csv',
                                          :invoice_items => './fixtures/mock_invoice_items.csv',
                                          :transactions  => './fixtures/mock_transactions.csv',
                                          :customers => './fixtures/mock_customers.csv'})
      
      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.item_count).to be_a(Float)
    end

    it '#merchant count' do
     sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                          :merchants => './fixtures/mock_merchants.csv',
                                          :invoices => './fixtures/mock_invoices.csv',
                                          :invoice_items => './fixtures/mock_invoice_items.csv',
                                          :transactions  => './fixtures/mock_transactions.csv',
                                          :customers => './fixtures/mock_customers.csv'})

      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.merchant_count).to be_a(Float)
    end

    it '#average items per merchant' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                         :merchants => './fixtures/mock_merchants.csv',
                                         :invoices => './fixtures/mock_invoices.csv',
                                         :invoice_items => './fixtures/mock_invoice_items.csv',
                                         :transactions  => './fixtures/mock_transactions.csv',
                                         :customers => './fixtures/mock_customers.csv'})
      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.average_items_per_merchant).to eq(2.88)
    end

    it '#item count per merchant' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                           :merchants => './fixtures/mock_merchants.csv',
                                           :invoices => './fixtures/mock_invoices.csv',
                                           :invoice_items => './fixtures/mock_invoice_items.csv',
                                           :transactions  => './fixtures/mock_transactions.csv',
                                           :customers => './fixtures/mock_customers.csv'})
      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.item_count_per_merchant.class).to eq(Hash)
    end

    it '#average items per merchant standard deviation' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                          :merchants => './fixtures/mock_merchants.csv',
                                          :invoices => './fixtures/mock_invoices.csv',
                                          :invoice_items => './fixtures/mock_invoice_items.csv',
                                          :transactions  => './fixtures/mock_transactions.csv',
                                          :customers => './fixtures/mock_customers.csv'})
      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.average_items_per_merchant_standard_deviation).to eq(0)
    end

    it '#merchants with high item count' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                          :merchants => './fixtures/mock_merchants.csv',
                                          :invoices => './fixtures/mock_invoices.csv',
                                          :invoice_items => './fixtures/mock_invoice_items.csv',
                                          :transactions  => './fixtures/mock_transactions.csv',
                                          :customers => './fixtures/mock_customers.csv'})
      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.merchants_with_high_item_count.first).to be_a(Merchant)
    end

    it '#average average price per merchant ' do
      sales_engine = SalesEngine.from_csv({:items => './fixtures/mock_items.csv',
                                          :merchants => './fixtures/mock_merchants.csv',
                                          :invoices => './fixtures/mock_invoices.csv',
                                          :invoice_items => './fixtures/mock_invoice_items.csv',
                                          :transactions  => './fixtures/mock_transactions.csv',
                                          :customers => './fixtures/mock_customers.csv'})
      merchant_repo = sales_engine.merchants 

      expect(merchant_repo.average_average_price_per_merchant).to eq(350.29)
    end
  end
end
