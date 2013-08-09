require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, :domain => ENV['SENDGRID_DOMAIN'], :name => 'google'
end