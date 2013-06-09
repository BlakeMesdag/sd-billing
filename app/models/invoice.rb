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
    self.stripe_token = nil
    self.status = "failed"
  ensure
    save
  end

  def should_charge?
    stripe_token_changed? && paid_on.nil?
  end

  def generate_token
    self.token = SecureRandom.hex(16)
  end

  def generate_due_on
    self.due_on = Time.now.utc.next_month.beginning_of_month
  end

  def set_new_status
    self.status = 'new'
  end

  before_create :set_new_status

  before_validation :generate_token, unless: :token, on: :create
  before_validation :generate_due_on, unless: :due_on, on: :create

  after_commit :send_email, on: :create
  after_commit :charge_stripe_token, if: :should_charge?

  validates :name, :email, :description, :amount, :due_on, :token, presence: :true
end
