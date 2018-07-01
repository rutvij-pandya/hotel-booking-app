class Array

  def average(precision=2)
    (self.sum.to_f/self.size).round(precision)
  end

end