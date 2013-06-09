Batman.extend Batman.config,
  pathToHTML: '/assets/html'

class window.Billing extends Batman.App
  @resources 'invoices'
  @root 'invoices#index'