require 'bigdecimal'

class InvoiceItem
  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(invoice_item_info)
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity = invoice_item_info[:quantity].to_i
    @unit_price = BigDecimal((invoice_item_info[:unit_price].to_i / 100.to_f), 4)
    @created_at = Time.parse(invoice_item_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_item_info[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end