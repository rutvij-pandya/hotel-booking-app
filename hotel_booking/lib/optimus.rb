# encoding: UTF-8
require 'singleton'

##
# Id obfuscation based on Knuth's multiplicative hashing method. Given a simple integer
# like `2` it will produce an obfuscated version i.e `2033899500`.
#
# To start these are the 3 things you need:
#   1. Large prime number lower than 2147483647
#   2. The inverse prime so that `(PRIME * INVERSE) & MAX_INT == 1`
#   3. A large random integer lower than `2147483647`
#
#
# == Configuration
# The module should ideally be configured with a fixed set of values which can be pre-calculated
# and used for all encoding and decoding.
#
# @example How to configure
#   Optimus.configure do |config|
#     config.prime    = 1580030173
#     config.inverse  = 59260789
#     config.xor      = 1163945558
#   end
#
module Optimus

  # Singleton configuration class which is initialized
  # in Rails initializers once during app startup.
  class Configuration
    include Singleton
    attr_accessor :prime, :inverse, :xor
  end

  # Allows to configure the `Configuration` instance
  def self.configure
    yield configuration if block_given?
  end

  # Returns configuration instance
  # @return [Configuration]
  def self.configuration
    Configuration.instance
  end

  # Encodes an integer to another number.
  #
  # @example
  #   Optimus.encode(2) #=> 2033899500
  #
  # @param [Integer] value - Integer to convert to another number
  # @return [Integer] converted value
  def self.encode(value)
    # ensure that the value is integer
    value = to_i(value)
    ((value * configuration.prime).to_i & MAX_INT) ^ configuration.xor
  end

  # Decodes an obfuscated integer to its original value.
  #
  # @example
  #   Optimus.decode(2033899500) #=> 2
  #
  # @param [Integer] value - Integer to convert to original value
  # @return [Integer] original value
  def self.decode(value)
    # ensure that the value is integer
    value = to_i(value)
    ((value ^ configuration.xor).to_i * configuration.inverse) & MAX_INT
  end

  private

  def self.to_i(value)
    if value.is_a?(String)
      Integer(value)
    else
      value
    end
  rescue
    0
  end

  # Max int value
  MAX_INT = 214_748_3647

end