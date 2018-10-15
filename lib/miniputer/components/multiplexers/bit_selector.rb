class BitSelector < CompositeComponent

  def self.blueprint
    {
      components: {
        n_selector_bit: NotGate,
        select1: AndGate,
        select2: AndGate,
        out_gate: OrGate
      },
      connections: {
        [:IN, :in1] => [[:select1, :in1]],
        [:IN, :in2] => [[:select2, :in1]],
        [:IN, :selector_bit] => [[:select2, :in2], [:n_selector_bit, :in1]],
        [:n_selector_bit, :out] => [[:select1, :in2]],
        [:select1, :out] => [[:out_gate, :in1]],
        [:select2, :out] => [[:out_gate, :in2]],
        [:out_gate, :out] => [[:OUT, :out]]
      }
    }
  end
end
