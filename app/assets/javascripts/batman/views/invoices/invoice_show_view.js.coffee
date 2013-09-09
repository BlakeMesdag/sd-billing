class Billing.InvoicesShowView extends Batman.View
  @accessor 'friendlyInvoiceDueOn', ->
    moment(@controller.get('invoice.due_on')).fromNow()

  payInvoice: (invoice) ->
    StripeCheckout.open
      key: Billing.get('stripeKey'),
      address: false,
      amount: invoice.get('amount') * 100,
      currency: 'CAD',
      name: invoice.get('name'),
      description: invoice.get('description'),
      panelLabel: 'Pay Invoice',
      token: @invoicePaidCallback

  invoicePaidCallback: (response) =>
    invoice = @controller.get('invoice')
    invoice.set('stripe_token', response.id)
    invoice.save (err, response) =>
      @controller.set('invoice', invoice)
