require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'sales_analyst'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require_relative 'findable'

class SalesEngine
  include Findable
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(paths)
   @items = ItemRepo.new(paths[:items], self)
   @merchants = MerchantRepo.new(paths[:merchants], self)
   @analyst = SalesAnalyst.new(self)
   @invoices = InvoiceRepo.new(paths[:invoices], self)
   @invoice_items = InvoiceItemRepo.new(paths[:invoice_items], self)
   @transactions = TransactionRepo.new(paths[:transactions], self)
   @customers = CustomerRepo.new(paths[:customers], self)
  end

  def self.from_csv(paths)
    new(paths)
  end

  def average_items_per_merchant
    @merchants.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @merchants.average_items_per_merchant_standard_deviation
  end

  def average_item_price_standard_deviation
    @items.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    @merchants.merchants_with_high_item_count
  end

  def average_item_price_for_merchant(merchant_id)
    @items.average_item_price_for_merchant(merchant_id)
  end

  def average_average_price_per_merchant
    @merchants.average_average_price_per_merchant
  end

  def average_invoices_per_merchant
    @invoices.average_invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    @invoices.average_invoices_per_merchant_standard_deviation
  end

  def top_merchants_by_invoice_count
    @invoices.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @invoices.bottom_merchants_by_invoice_count
  end

  def invoice_status(status)
    @invoices.invoice_status(status)
  end

  def revenue_by_merchant_id(invoice_id)
    @merchants.revenue_by_merchant_id(invoice_id)
  end

  def top_revenue_earners(range)
    @merchants.top_revenue_earners(range)
  end

  def merchants_with_pending_invoices
    @merchants.merchants_with_pending_invoices
  end

  def merchants_ranked_by_revenue
    @merchants.merchants_ranked_by_revenue
  end

  def invoice_paid_in_full?(invoice_id)
    @transactions.invoice_paid_in_full?(invoice_id)
  end

  def invoice_total(id)
    @invoices.invoice_total(id)
  end

  def total_revenue_by_date(date)
    @invoices.total_revenue_by_date(date)
  end

  def merchants_with_only_one_item
    @merchants.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    @merchants.merchants_with_only_one_item_registered_in_month(month)
  end

  def revenue_by_merchant(merchant_id)
    @merchants.revenue_by_merchant(merchant_id)
  end
end
