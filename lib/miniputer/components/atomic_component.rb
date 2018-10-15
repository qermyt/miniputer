require_relative 'component_base'

class AtomicComponent < ComponentBase
  def self.build_input_wires
    input_labels.map { |label| [label, Wire.new] }.to_h
  end

  def self.build
    self.new(input_wires: build_input_wires)
  end

  def load
    @inputs = @input_wires.map { |_, wire| wire.value }
  end

  def create_output_wires
    @output_wires = self.class.output_labels.map do |label|
      [label, Wire.new(upstream: self, label: label)]
    end.to_h
  end

  def full_perform
    load
    perform
  end

  def perform
    internal_perform
  end

  def internal_wires
    @output_wires.values
  end

  def atomic_connections(cw_label)
    [[self, cw_label.last]]
  end

  def attach_input_wires(wire_hash)
    super
    wire_hash.each { |_, wire| wire.attach(self) }
  end

  def attach_input_wire(wire)
    super
    wire.attach(self)
  end

  def attach_wire(wire, (_in, label))
    @input_wires[label] = wire
    wire.attach(self)
  end

  def connect_wires
  end

  private

  def prepare_internals
    create_output_wires
  end
end
