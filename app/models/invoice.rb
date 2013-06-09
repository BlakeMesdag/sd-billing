class Invoice < ActiveRecord::Base
  def send_email
    return unless email
    InvoiceMailer.invoice_created(self).deliver
  end

  def charge_stripe_token
    customer = Stripe::Customer.create(email: email, card: stripe_token)
    charge = Stripe::Charge.create(customer: customer.id, amount: (amount * 100).to_i, description: description, currency: 'CAD')
    self.paid_on = Time.now.utc
    self.status = "paid"
  rescue Stripe::CardError
    self.status = "failed"
  ensure
    save
  end

  def should_charge?
    stripe_token_changed? && paid_on.nil?
  end

  after_commit :send_email, on: :create
  after_commit :charge_stripe_token, if: :should_charge?
end
