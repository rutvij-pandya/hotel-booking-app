class BookingsController < ApplicationController

  include BookingHelpers
  include HotelHelpers

  # POST /bookings.json
  def create
    begin
      booking = create_booking(permitted_params)

      booking.save!

      # ------------ TEMPORARY -------------
      # Stripe Token is expected from UI
      # Temporarily it has been created here
      # ------------------------------------
      # Valid card    - 4242424242424242
      # card declined - 4000000000000002
      stripe_token =  Stripe::Token.create(
                        :card => {
                          :number => "4242424242424242",
                          :exp_month => 6,
                          :exp_year => 2019,
                          :cvc => "314"
                        },
                      )
      # ---------------------

      # create a Payment record in 'pending' state
      payment = booking.build_payment(stripe_token: (permitted_params[:stripe_token] || stripe_token.id),
                                      amount: booking.amount)

      payment.save!
            
      StripeChargeService.new(customer_email: permitted_params[:customer_email], 
                              stripe_token: (permitted_params[:stripe_token] || stripe_token.id), 
                              booking: booking,
                              payment: payment).call

      render json: { booking_id: Optimus.encode(booking.id) }, status: :created
    rescue => e
      render json: { errors: [e.message] }, status: :unprocessable_entity
    rescue Stripe::CardError => e
      render json: { errors: [e.message] }, status: :unprocessable_entity
    end
  end


  private

  def permitted_params
    params.permit(:check_in_date,
                  :check_out_date,
                  :customer_email,
                  :stripe_token).merge(room_type_id: decode(params[:room_type_id]))
  end

end
