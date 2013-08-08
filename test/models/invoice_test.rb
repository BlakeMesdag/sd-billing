require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "create sends email" do
    invoice = Invoice.create(email: "test@test.com", name: "test", description: "test", due_on: Time.now.utc + 7.days, amount: 20.00, token: "1234567890")
    invoice.expects(:send_email).returns(nil)

    invoice.run_callbacks(:commit)
  end

  test "update creates a customer and charge if a stripe_token is added and not already paid" do
    invoice = invoices(:bobserver)

    Stripe::Customer.expects(:create).with(email: "bob@tester.com", card: "1234567890").returns(stub(id: 1))
    Stripe::Charge.expects(:create).with(customer: 1, amount: 2000, description: 'Server', currency: 'CAD').returns(nil)

    assert_nil invoice.paid_on

    invoice.assign_attributes(stripe_token: '1234567890')
    invoice.run_callbacks(:save)

    assert_not_nil invoice.paid_on
    assert_equal 'paid', invoice.status
  end

  test "update status changes to failed if Stripe::CardError raised" do
    invoice = invoices(:bobserver)

    Stripe::Customer.expects(:create).with(email: "bob@tester.com", card: "1234567890").returns(stub(id: 1))
    Stripe::CardError.any_instance.expects(:initialize).returns(nil)
    Stripe::Charge.expects(:create).with(customer: 1, amount: 2000, description: 'Server', currency: 'CAD').raises(Stripe::CardError)

    assert_nil invoice.paid_on

    invoice.assign_attributes(stripe_token: '1234567890')
    invoice.run_callbacks(:save)

    assert_nil invoice.paid_on
    assert_equal 'failed', invoice.status
  end

  test "Name, email, description, amount, due_on, token are required" do
    invoice = Invoice.new

    assert !invoice.valid?
    assert invoice.errors[:name]
    assert invoice.errors[:email]
    assert invoice.errors[:description]
    assert invoice.errors[:amount]
    assert invoice.errors[:due_on]
    assert invoice.errors[:token]
  end
end
