class NotGate < AtomicComponent
  def self.input_labels
    [:in1]
  end

  def self.output_labels
    [:out]
  end

  def out(_ = nil)
    @output_wires[:out]
  end

  private

  def internal_perform
    out.set_value(!@input_wires[:in1].value)
  end

  def no_of_inputs
    1
  end

  def no_of_outputs
    1
  end
end
