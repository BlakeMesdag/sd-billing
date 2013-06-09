class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :token
      t.string :stripe_token
      t.string :description
      t.string :email
      t.string :name
      t.string :status
      t.datetime :due_on
      t.datetime :paid_on

      t.timestamps
    end
  end
end
