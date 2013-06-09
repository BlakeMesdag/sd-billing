class Invoice < ActiveRecord::Base
  def send_email
    return unless email
    InvoiceMailer.created_invoice(self).deliver
  end

  after_commit :send_email, on: :create
end
