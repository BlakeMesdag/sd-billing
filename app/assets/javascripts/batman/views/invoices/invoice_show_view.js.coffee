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

  initNewInvoice: ->
    @set 'newInvoice', new Billing.Invoice

  createInvoice: (invoice) =>
    invoice.save (err, invoice) =>
      if !err
        Billing.Invoice.get('loaded').add(invoice)
        @unset 'newInvoice'

  destroyInvoice: (invoice) =>
    return unless confirm("Are you sure you want to destroy #{invoice.get('description')}?")
    invoice.destroy (err, invoice) =>
      if !err
        Billing.Invoice.get('loaded').remove(invoice)

  cancelNewInvoice: ->
    @unset 'newInvoice'