Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :hotels, only: [:index], as: :hotels do 
    member do 
      get "/:room_type_id/availability", to: "hotels/actions#availability", as: :hotel_availability
    end
  end

  resources :bookings, only: [:create, :show]

  # Stripe Webhook Routes
  mount StripeEvent::Engine, at: '/events'
end
