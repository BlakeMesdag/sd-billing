require 'test_helper'

class InvoiceMailerTest < ActionMailer::TestCase
  def setup
    @mailer = InvoiceMailer
    @invoice = invoices(:bobserver)
  end

  test "invoice_created" do
    mail = @mailer.invoice_created(@invoice)
    assert_equal "New Invoice Available", mail.subject
    assert_equal ["bob@tester.com"], mail.to
    assert_equal ["billing@somethingdevio.us"], mail.from
    assert_match "Hi Bob Tester,", mail.body.encoded
    assert_match @invoice.token, mail.body.encoded
  end

end
