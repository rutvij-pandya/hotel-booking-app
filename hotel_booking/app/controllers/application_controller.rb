class ApplicationController < ActionController::API

  include ActionController::RequestForgeryProtection
  # Encode/ Decode Primary & Foreign key values
  include OptimusHelper
  # Exceptions handler 
  include Error::ApiErrorHandler
  
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  



end
