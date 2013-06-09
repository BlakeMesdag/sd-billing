class Billing.HTMLStore extends Batman.HTMLStore
  # Class level _viewAssetPaths is defined by the admin2 index html.
  @registerHTML: (viewMap) ->
    for path, content of viewMap
      Batman.View.store.set(Batman.Navigator.normalizePath(path.replace(/^html\//, '')), content)
  fetchHTML: (path) ->
    throw "View for #{path} isn't loaded!"

Batman.View.store = new Billing.HTMLStore
