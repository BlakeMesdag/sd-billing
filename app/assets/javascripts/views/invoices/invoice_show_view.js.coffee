class Billing.InvoicesShowView extends Batman.View
  @accessor 'friendlyInvoiceDueOn', ->
    moment(@controller.get('invoice.due_on')).fromNow()