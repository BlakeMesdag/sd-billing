class Billing.InvoicesController extends Batman.Controller
  routingKey: 'invoices'

  index: ->
    NProgress.start()

    Billing.Invoice.load (err, invoices) =>
      if !err
        @set 'invoices', Billing.Invoice.get('loaded')
      NProgress.done()


  show: (params) ->
    NProgress.start()

    Billing.Invoice.find params.id, (err, invoice) =>
      if !err
        @set 'invoice', invoice

      NProgress.done()
