module OptimusHelper

  # Encode value of Primary & Foreign Keys while sending in API Response JSON 
  def encode(id)
    Optimus.encode(id)
  end

  # Decode value of Primary & Foreign Keys received in API Request params
  def decode(id)
    Optimus.decode(id)
  end

end