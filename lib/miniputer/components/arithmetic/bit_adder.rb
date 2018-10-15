class BitAdder < CompositeComponent
  def name
    'Adder'
  end

  def sym_name
    'adder'
  end

  def self.blueprint
    {
      components: {
        or: OrGate,
        carry: AndGate,
        n_carry: NotGate,
        sum: AndGate
      },
      connections: {
        [:IN, :bit1]     => [[:or, :in1], [:carry, :in1]],
        [:IN, :bit2]     => [[:or, :in2], [:carry, :in2]],
        [:or, :out]      => [[:sum, :in1]],
        [:n_carry, :out] => [[:sum, :in2]],
        [:sum, :out]     => [[:OUT, :sum]],
        [:carry, :out]   => [[:n_carry, :in1], [:OUT, :carry]]
      }
    }
  end

  private

  def set_layout
    @or1.position = [2, 2]
    @or1.position = [2, 3]
  end
end
