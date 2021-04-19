require 'CSV'
require 'invoice_item_repository'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/item_repo'
require 'bigdecimal'

RSpec.describe InvoiceItemRepository do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                      })
  end

  describe 'instantiation' do
    it '::new' do
      invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", @repo)

      expect(invoice_item_repo).to be_an_instance_of(InvoiceItemRepository)
    end

    xit 'has attributes' do
      invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", @repo)

      expect(invoice_item_repo.invoice_items).to eq([])
    end
  end

  describe '#methods' do
    xit '#all returns an array of all invoice item instances' do
      invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", @repo)

      expect(invoice_item_repo.all).to be_an_instance_of(Array)
    end

    xit '#find_by_id finds an invoice_item by id' do
      invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", @repo)

      expect(invoice_item_repo.id).to_eq(id)
      expect(invoice_item_repo.item_id).to eq 263523644
      expect(invoice_item_repo.invoice_id).to eq 2
    end

    xit 'find_all_by_item_id finds all items matching given item_id' do
      invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", @repo)

      expect(invoice_item_repo.length).to eq 11
    end

    xit '#find_all_by_item_id returns an empty array if there are no matches' do
      invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items.csv", @repo)

      expect(invoice_item_repo.length).to eq 0
      expect(invoice_item_repo.empty?).to eq true
    end

    xit '#create creates a new invoice item instance' do
      attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }

      engine.invoice_items.create(attributes)
      #not completely sure what engine is or what needs to happen here?
      expected = engine.invoice_items.find_by_id(21831)
      expect(invoice_items.item_id).to eq 7
    end

    xit '#update updates an invoice item' do
      original_time = engine.invoice_items.find_by_id(21831).updated_at
      attributes = {
        quantity: 13
      }
      engine.invoice_items.update(21831, attributes)
      expected = engine.invoice_items.find_by_id(21831)
      expect(invoice_items.quantity).to eq 13
      expect(invoice_items.item_id).to eq 7
      expect(invoice_items.updated_at).to be > original_time
    end

    xit '#update cannot update id, item_id, invoice_id, or created_at' do
      attributes = {
        id: 22000,
        item_id: 32,
        invoice_id: 53,
        created_at: Time.now
      }
      engine.invoice_items.update(21831, attributes)
      expected = engine.invoice_items.find_by_id(22000)
      expect(invoice_items).to eq nil
      expected = engine.invoice_items.find_by_id(21831)
      expect(invoice_item_repo.item_id).not_to eq attributes[:item_id]
      expect(invoice_item_repo.invoice_id).not_to eq attributes[:invoice_id]
      expect(invoice_item_repo.created_at).not_to eq attributes[:created_at]
    end

    xit '#update on unknown invoice item does nothing' do
      engine.invoice_items.update(22000, {})
    end

    xit '#delete deletes the specified invoice' do
      engine.invoice_items.delete(21831)
      expected = engine.invoice_items.find_by_id(21831)
      expect(invoice_items).to eq nil
    end

    xit 'delete on unknown invoice does nothing' do
      engine.invoice_items.delete(22000)
    end
  end
end
