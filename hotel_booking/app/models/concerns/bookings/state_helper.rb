# frozen_string_literal: true
module Bookings::StateHelper
  extend ActiveSupport::Concern

    def self.included(base)

      base.class_eval do

        # => State management & Transition restrictions
        aasm column: :status, enum:true do

          state :pending, initial: true
          state :confirmed
          state :failed
          state :canceled

          # Payment has been processed Successfully
          event :mark_confirmed do
            transitions from: :pending, to: :confirmed            
          end

          # Payment has been Failed to be processed
          event :mark_failed do 
            transitions from: :pending, to: :failed
          end

          # Restriction - A Booking in 'Pending' OR 'Failed' state cannot be marked as 'Canceled'
          #             - Only 'Confirmed' Booking can be 'Canceled' 
          event :cancel do 
            transitions from: :confirmed, to: :canceled
          end

        end

      end
    end

end