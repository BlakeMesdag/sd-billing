require 'sprockets/jsonp_html_wrapper'
::Sprockets::JsonpHtmlWrapper.callback = 'Billing.HTMLStore.registerHTML'
Rails.application.assets.register_engine '.htm', ::Sprockets::JsonpHtmlWrapper
