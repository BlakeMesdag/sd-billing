class AddStripeTokenToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :stripe_token, :string
  end
end
