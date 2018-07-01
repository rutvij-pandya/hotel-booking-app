module StripeActions
  # Handle 'charge.failed' stripe event    
  # Update Payment status of Charge 
  class ChargeFailed

    def call(event)
      data = event.data.object
      
      # "metadata"=>{
      #   "customer"=>"rutvij.pandya.2010@gmail.com", 
      #   "hotel"=>"1200488676", 
      #   "room_type"=>"204266633", 
      #   "payment"=>"1721936171"}, 
      metadata = data.metadata

      payment = Payment.find(Optimus.decode(metadata["payment"]))
      payment.charge_failed(data)      
    end

  end
end
