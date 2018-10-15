class HighSource < AtomicComponent
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

  def prepare_internals
    super
    @output_wires[:out].set_value(HIGH)
  end

  def internal_perform
    nil
  end
end
