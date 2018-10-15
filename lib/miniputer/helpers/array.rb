class Array
  def shallow_flatten
    self.inject([]) do |arr, i|
      arr.push(*i)
    end
  end
end
