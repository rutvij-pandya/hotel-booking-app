require 'optimus'

# Configure optimus
Optimus.configure do |config|
  # raise error if missing env
  raise StandardError.new('Missing Env configs for Optimus') if ENV['OPTIMUS_PRIME'].blank?

  config.prime   = Integer(ENV['OPTIMUS_PRIME'])
  config.inverse = Integer(ENV['OPTIMUS_INVERSE'])
  config.xor     = Integer(ENV['OPTIMUS_XOR'])
end
