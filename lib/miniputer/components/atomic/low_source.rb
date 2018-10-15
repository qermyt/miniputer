class LowSource < AtomicComponent
  def self.input_labels
    []
  end

  def self.output_labels
    [:out]
  end

  def out(_ = nil)
    @output_wires[:out]
  end

  private

  def internal_perform
    nil
  end

  def no_of_inputs
    0
  end

  def no_of_outputs
    1
  end
end
