class WireSplitter < AtomicComponent
  def self.input_labels
    [:data_in]
  end

  def self.output_labels
    []
  end

  def out(i)
    @input_wires[:data_in][i-1]
  end

  def attach_wire(wire, _source)
    @input_wires[:data_in] = wire
  end

  private

  def internal_perform
    nil
  end

  def no_of_inputs
    1
  end

  def no_of_outputs
    0
  end
end
