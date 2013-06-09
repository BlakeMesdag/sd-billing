require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, :domain => 'somethingdevio.us', :name => 'google'
end