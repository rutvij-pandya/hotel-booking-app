require 'dry-initializer'

class StripeChargeService
  extend Dry::Initializer

  option :customer_email

  option :stripe_token

  option :booking
  
  option :payment
  

  def call
    StripeActions::CreateCharge.new( customer_email: customer_email,
                                            booking: booking,
                                            payment: payment,
                                            token:   stripe_token).perform
  end

  private

  def retrieve_token(stripe_token)
    Stripe::Token.retrieve(stripe_token) 
  end

end