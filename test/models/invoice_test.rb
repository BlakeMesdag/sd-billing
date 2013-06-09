require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "create sends email" do
    invoice = Invoice.create(email: "test@test.com")
    invoice.expects(:send_email).returns(nil)

    invoice.run_callbacks(:commit)
  end

  test "update creates a customer and charge if a stripe_token is added and not already paid" do
    invoice = invoices(:bobserver)

    Stripe::Customer.expects(:create).with(email: "bob@tester.com", card: "1234567890").returns(stub(id: 1))
    Stripe::Charge.expects(:create).with(customer: 1, amount: 2000, description: 'Server', currency: 'CAD').returns(nil)
    invoice.expects(:save).returns(nil)

    assert_nil invoice.paid_on

    invoice.assign_attributes(stripe_token: '1234567890')
    invoice.run_callbacks(:commit)

    assert_not_nil invoice.paid_on
    assert_equal 'paid', invoice.status
  end

  test "update status changes to failed if Stripe::CardError raised" do
    invoice = invoices(:bobserver)

    Stripe::Customer.expects(:create).with(email: "bob@tester.com", card: "1234567890").returns(stub(id: 1))
    Stripe::CardError.any_instance.expects(:initialize).returns(nil)
    Stripe::Charge.expects(:create).with(customer: 1, amount: 2000, description: 'Server', currency: 'CAD').raises(Stripe::CardError)
    invoice.expects(:save).returns(nil)

    assert_nil invoice.paid_on

    invoice.assign_attributes(stripe_token: '1234567890')
    invoice.run_callbacks(:commit)

    assert_nil invoice.paid_on
    assert_equal 'failed', invoice.status
  end
end
