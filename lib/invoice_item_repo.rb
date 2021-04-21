require 'CSV'
require 'bigdecimal'
require 'invoice_item'
require_relative 'findable'
include Findable

class InvoiceItemRepo
  attr_reader :invoice_items,
              :engine

  def initialize(path, engine)
    @invoice_items = []
    @engine = engine 
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    @invoice_items
  end

  def create(attributes)
    invoice_item = InvoiceItem.new(attributes, self)
    max = @invoice_items.max_by do |invoice_item|
      invoice_item.id
    end
    invoice_item.update_id(max.id)
    @invoice_items << invoice_item
    invoice_item
  end

  def update(id, attributes)
    item_invoice = find_by_id(id)
    return if !item_invoice
    invoice_item.update_all(atrributes)
  end

  def delete(id)
    @invoice_items.delete(find_by_id(id))
  end
end

