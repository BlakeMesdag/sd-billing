class InvoiceMailer < ActionMailer::Base
  default from: "billing@somethingdevio.us"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invoice.invoice_created.subject
  #
  def invoice_created(invoice)
    @invoice = invoice
    mail to: invoice.email, subject: "New Invoice Available"
  end
end
