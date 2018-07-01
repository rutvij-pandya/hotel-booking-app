# frozen_string_literal: true

require 'stripe'
require 'dry-initializer'

module StripeActions
  # Creates a Stripe Chrage to charge user for Monthly subscription's prorate
  class CreateCharge < BaseAction
    extend Dry::Initializer

    option :customer_email
    option :booking
    option :payment
    option :token


    def perform

      charge_params = {
        amount: booking.amount,
        currency: Payment::BASE_CURRENCY,
        source: token
      }

      charge_params.merge!(options)

      Stripe::Charge.create(charge_params)
    end

    private

    # Returns Options to be sent in Stripe::Charge.create API
    def options
      options = {
        description: charge_description,
        metadata: metadata
      }

      options
    end

    def charge_description
      I18n.t('app.name') + " Hotel Booking - #{booking.hotel.name}"
    end

    def metadata
      {
        customer: customer_email,
        hotel: Optimus.encode(booking.hotel_id),
        room_type: Optimus.encode(booking.room_type_id),
        payment: Optimus.encode(payment.id)
      }
    end

  end
end
