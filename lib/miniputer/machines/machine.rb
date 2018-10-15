require_relative 'runnable'

class Machine
  include Runnable

  def initialize(circuit:)
    @circuit = circuit.build
  end

  def bulbs
    @bulbs ||= {}.merge(
      circuit.output_wires.transform_values { |_, v| v.to_a }
    )
  end

  def switches
    @switches ||= circuit.input_wires.transform_values { |_, v| v.to_a }
  end

  def display_switches
    switches
  end


  private

  def circuit
    @circuit
  end
end
