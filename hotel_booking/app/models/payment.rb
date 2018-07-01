class Payment < ApplicationRecord

  include AASM

  BASE_CURRENCY = "USD"

  # --- Associations
  belongs_to :booking

  ## enum - Status
  #
  ## IMPORTANT - While adding new options in Status Enum, 
  ##             MUST ENSURE to add it's transition restrictions in Payments::StateHelper
  enum status: [:pending, :success, :failed]
  # State machine implementation
  include Payments::StateHelper

  # -- Accessors to quickly access fields under transaction_data
  # Defining 'transaction_data' field as JSONB gives flexibility to store more info flawlessly when needed.
  jsonb_accessor :transaction_data,
                 charge:            :string,
                 currency:          :string,
                 error:             :json # failure_code, failure_msg


end
