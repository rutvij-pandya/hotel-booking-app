module Error
  # Base error class to be extended by all other custom errors
  class CustomError < StandardError
    attr_reader :error, :status, :message

    def initialize(error, status, message)
      @error = error || 422
      @status = status || :unprocessable_entity
      @message = message || 'Oops, something went wrong!'
    end

    def fetch_json
      Helpers::Render.json(error, status, message)
    end
  end
end

