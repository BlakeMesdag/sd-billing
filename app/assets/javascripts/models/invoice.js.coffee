class Billing.Invoice extends Batman.Model
  @resourceName: 'invoice'
  @primaryKey: 'token'
  @persist Batman.RailsStorage

  @encode 'amount', 'description', 'name', 'email', 'token', 'status', 'stripe_token'
  @encodeTimestamps 'due_on', 'paid_on', 'created_at', 'updated_at'

  @accessor 'statusLabel', ->
    switch @get('status')
      when 'new'
        ''
      when 'paid'
        'label-success'
      when 'failed'
        'label-warning'