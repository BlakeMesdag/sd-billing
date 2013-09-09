class Billing.InvoicesIndexView extends Batman.View
  destroyInvoice: (invoice) =>
    return unless confirm("Are you sure you want to destroy #{invoice.get('description')}?")
    invoice.destroy (err, invoice) =>
      if !err
        Billing.Invoice.get('loaded').remove(invoice)

  initNewInvoice: ->
    @set 'newInvoice', new Billing.Invoice

  createInvoice: (invoice) =>
    invoice.save (err, invoice) =>
      if !err
        Billing.Invoice.get('loaded').add(invoice)
        @unset 'newInvoice'

  cancelNewInvoice: ->
    @unset 'newInvoice'