class WireJoiner < AtomicComponent
  def self.input_labels
    (1..self.no_of_bits).to_a
  end

  def self.output_labels
    [:out]
  end

  def out(_label)
    @out ||= data_wire
  end

  def attach_wire(wire, (_in, index))
    @input_wires[index] ||= wire
  end

  def connect_wires
    @input_wires = {}
    (1..self.class.no_of_bits).each do |i|
      @input_wires[i] = super_component.wire_from_sink([label, i])
    end
  end


  private

  def data_wire
    connect_wires if @input_wires.empty?
    return nil if @input_wires.empty?
    @data_wire ||= DataWire.new(*@input_wires.sort.to_h.values)
  end

  def internal_perform
    nil
  end

  def no_of_inputs
    self.class.no_of_bits
  end

  def no_of_outputs
    0
  end

  def prepare_internals
    return
    @input_wires = {}
    (1..self.class.no_of_bits).each do |i|
      @input_wires[i] = super_component.wire_from_sink([label, i])
    end
  end
end
