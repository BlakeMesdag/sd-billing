class Billing.InvoicesController extends Batman.Controller
  routingKey: 'invoices'
  index: ->
    Billing.Invoice.load (err, invoices) =>
      if !err
        @set 'invoices', Billing.Invoice.get('loaded')

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
     invoice.save (err, response) =>
       @set('invoice', invoice)

   initNewInvoice: (invoice) =>
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