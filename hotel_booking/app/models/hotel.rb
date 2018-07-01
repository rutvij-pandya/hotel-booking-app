class Hotel < ApplicationRecord

  # A Boolean flag to indicate hotel's availability during the serach period
  attr_accessor :availability  

  # --- Associations
  has_one :picture, as: :imageable
  has_many :room_types 
  has_many :bookings 

  # --- Validations
  validates :name, presence: true, length: { minimum: 3 }  

  # -- Callbacks
  before_save :generate_slug

  # -- Enums
  ## enum status 
  # (Note - status are briefly planned consedring a hypothetical hotel onboarding process on the admin portal)
  # pending     - Hotel onboarding is in progress. In this state, system has in-complete details about the hotel.
  # active      - Hotel is ready to be displayed to the customer & accept the bookings.
  # deactivated - Hotel is no more associated with the company (temporarily/ permanently)
  enum status: [:pending, :active, :deactivated]


  # -- Scopes
  scope :by_slug, -> (slug) { where(slug: slug) }
  
  # Confirms Hotel's availability
  def available?(hotel_availability)
    result = true

    if hotel_availability.present?
      # Total available rooms in a hotel
      total_rooms = self.room_types.sum(&:quantity)    
      result = (total_rooms != hotel_availability["booked_rooms"])
    end
    
    result
  end

  private

  # Generates slug of the title
  # i.e, self.title = 1906 Mission Hotel
  #      self.slug = 1906-mission-hotel
  def generate_slug
    self.slug = self.name.parameterize
  end

end
