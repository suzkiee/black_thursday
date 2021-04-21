# Black Thursday

Find the [project spec here](http://backend.turing.io/module1/projects/black_thursday/).

## I4 Blog Post 
### sales_analyst.most_sold_item_for_merchant(merchant_id): This method must look at any given merchant_id, find the valid item(s) (an item is valid if the invoice is paid in full) that have the highest quantity sold and return it in a new array. In the event of a tie, it should also be able to return each item in that new array. To do this...

### Directories | Data Needed: 
Merchant_repo.rb | Merchant IDs (.all method)
Invoice_Item_Repo.rb/Invoice_Item | Individual item quantity (@quantity)
Sales_analyst.rb | Paid in full for validity  (invoice_paid_in_full?)
Item_repo.rb & Invoice_repo | Updated at for determining status (@updated_at)

## Initial Thoughts: merchant_id (calling), item (returning), invoice_items (connecting invoice_item to merchant_id), transaction (to check for validity of invoice)

Have to create a value or object that holds the amount_of_invoices_per_merchant
Iterate over @invoices and return_by_merchant_id → collect the merchant_ids from the invoices
Set those ids equal to the merchant object. (Match merchant_id to invoice_items)
Then connect those invoices to invoice_items
Merchant → invoice → invoice_items, then find quantity and unit_price of all the items in that invoice.
Collective item invoices should return quantity & unit_price_per_item
Need to also create a method that shows how many specific items that merchant has, then add up the unit price of those items (merchant = quantity + price)

## To Keep in Mind:
Will ultimately need a way to access which object is seen most frequently among all item invoices that are paid in full.

sales_analyst.best_item_for_merchant(merchant_id): This method must look at any given merchant_id, iterate through each merchant to find the item(s) that have the highest quantity sold then, find the item(s) among those that have the highest revenue generated and return that item in a new array. In the event of a tie, it should also be able to return each item in that new array. To do this…

## Directories | Data needed
Item_repo.rb & Invoice_repo | Updated at for determining status (@updated_at)
Sales_analyst.rb & Transaction_repo | Paid in full for validity &  (invoice_paid_in_full?)
Merchant_repo.rb | Merchant IDs & Revenue by merchant id (.all method | revenue_by_merchant_id)
Invoice_item.rb | Update at to determine status (@update_updated_at)
