class FourOneBitSelecter < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        bit_gate1: AndGate,
        bit_gate2: AndGate,
        bit_gate3: AndGate,
        bit_gate4: AndGate,
        pre_out1: OrGate,
        pre_out2: OrGate,
        out: OrGate
      },
      connections: {
        [:IN, :in1] => [[:bit_gate1, :in1]],
        [:IN, :in2] => [[:bit_gate2, :in1]],
        [:IN, :in3] => [[:bit_gate3, :in1]],
        [:IN, :in4] => [[:bit_gate4, :in1]],

        [:IN, :selector_bit1] => [[:bit_gate1, :in2]],
        [:IN, :selector_bit2] => [[:bit_gate2, :in2]],
        [:IN, :selector_bit3] => [[:bit_gate3, :in2]],
        [:IN, :selector_bit4] => [[:bit_gate4, :in2]],

        [:bit_gate1, :out] => [[:pre_out1, :in1]],
        [:bit_gate2, :out] => [[:pre_out1, :in2]],
        [:bit_gate3, :out] => [[:pre_out2, :in1]],
        [:bit_gate4, :out] => [[:pre_out2, :in2]],

        [:pre_out1, :out] => [[:out, :in1]],
        [:pre_out2, :out] => [[:out, :in2]],

        [:out, :out] => [[:OUT, :out]]
      }
    }
  end
end
