class Picture < ApplicationRecord

  # --- Associations
  belongs_to :imageable, polymorphic: true  

end
