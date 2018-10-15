class Hash
  def arrify_values
    self.map do |k, v|
      [k, [v]]
    end.to_h
  end

  def transform_values
    self.map do |k, v|
      [k, yield(k, v)]
    end.to_h
  end
end
