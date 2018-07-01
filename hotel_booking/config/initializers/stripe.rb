require 'stripe'
Stripe.api_key = Rails.application.secrets.stripe_secret_key
StripeEvent.signing_secret = Rails.application.secrets.signing_secret

Rails.configuration.stripe_publishable_key = Rails.application.secrets.stripe_publishable_key


# Subscribe to Stripe Events and handle event triggred on Stripe
StripeEvent.configure do |events|
  
  events.subscribe 'charge.succeeded', StripeActions::ChargeSucceeded.new

  events.subscribe 'charge.failed', StripeActions::ChargeFailed.new

end
