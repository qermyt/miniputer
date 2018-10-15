class AndGate < AtomicComponent
  def self.input_labels
    %i(in1 in2)
  end

  def self.output_labels
    [:out]
  end

  def out(_ = nil)
    @output_wires[:out]
  end

  private

  def internal_perform
    debugger if @input_wires[:in1].nil? || @input_wires[:in2].nil?
    out.set_value(@input_wires[:in1].value && @input_wires[:in2].value)
  end
end
