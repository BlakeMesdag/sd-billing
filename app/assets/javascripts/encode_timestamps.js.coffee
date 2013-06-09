Batman.Model.encodeTimestamps = (attrs...) ->
  if attrs.length == 0
    attrs = ['created_at', 'updated_at']
  @encode attrs..., {encode: false, decode: Batman.Encoders.railsDate.decode}