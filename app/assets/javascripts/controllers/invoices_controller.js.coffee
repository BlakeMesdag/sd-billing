class Billing.InvoicesController extends Batman.Controller
  routingKey: 'invoices'
  index: ->
    Billing.Invoice.load (err, invoices) =>
      if !err
        @set 'invoices', invoices

  show: (params) ->
    Billing.Invoice.find params.id, (err, invoice) =>
      if !err
        @set 'invoice', invoice

  goToInvoice: (invoice) ->
    Billing.navigator.redirect("/invoices/#{invoice.get('token')}")

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
     invoice = @get('invoice')
     invoice.set('stripe_token', response.id)
     invoice.save (err, response) ->
       console.log 'saved'