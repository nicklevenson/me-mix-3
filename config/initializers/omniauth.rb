
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:GOOGLE_CLIENT_ID], Rails.application.credentials.google[:GOOGLE_CLIENT_SECRET]
  provider :facebook, ENV['FACEBOOK_CLIENT_KEY'], ENV['FACEBOOK_CLIENT_SECRET']
end