# frozen_string_literal: true
module Payments::StateHelper
  extend ActiveSupport::Concern

    def self.included(base)

      base.class_eval do

        # => State management & Transition restrictions
        aasm column: :status, enum:true do

          state :pending, initial: true
          state :success
          state :failed

          # Payment has been processed Successfully
          event :charged, after: :set_transaction_data do
            transitions from: :pending, to: :success            
          end

          # Payment has been Failed to be processed
          event :charge_failed, after: :set_transaction_data_with_error do 
            transitions from: :pending, to: :failed
          end

        end

        private

        # Expects [Stripe] Charge webhook data object
        def set_transaction_data(data)
          self.charge = data.id # User Stripe::Charge.retrive(payment.charge) to get payment source details
          self.currency = data.currency
          self.error = {}
        
          self.save!
          # Update Booking status 
          self.booking.mark_confirmed!
        end

        # Expects [Stripe] Charge webhook data object
        def set_transaction_data_with_error(data)
          self.charge = data.id
          self.error = {
            failure_code: data.failure_code,
            failure_message: data.failure_message
          }

          self.save!
          # Update Booking status
          self.booking.mark_failed!
        end

      end
    end

end