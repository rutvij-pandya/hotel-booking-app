require 'active_support/rescuable'

module StripeActions
  class BaseAction
    include ActiveSupport::Rescuable
    
    # rescue from some Stripe Errors
    rescue_from Stripe::InvalidRequestError, with: :log_invalid_stripe_request
    
    private
    
    # Logs stripe exception error through ActiveSupport instrumentation events
    def log_invalid_stripe_request(exception)
      # logs stripe exception
      ActiveSupport::Notifications.instrument 'anyplace.stripe_action.failed', exception
    end
  end
end