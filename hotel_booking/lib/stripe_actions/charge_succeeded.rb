module StripeActions
  # Handle 'charge.succeeded' stripe event    
  # Update Payment status 
  class ChargeSucceeded

    def call(event)
      data = event.data.object
      
      # "metadata"=>{
      #   "customer"=>"rutvij.pandya.2010@gmail.com", 
      #   "hotel"=>"1200488676", 
      #   "room_type"=>"204266633", 
      #   "payment"=>"1721936171"}, 
      metadata = data.metadata

      payment = Payment.find(Optimus.decode(metadata["payment"]))
      payment.charged(data)
    end

  end
end
