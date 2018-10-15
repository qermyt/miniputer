class TripleAnd < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        and1: AndGate,
        and2: AndGate
      },
      connections: {
        [:IN, :in1] => [[:and1, :in1]],
        [:IN, :in2] => [[:and1, :in2]],
        [:IN, :in3] => [[:and2, :in1]],
        [:and1, :out] => [[:and2, :in2]],
        [:and2, :out] => [[:OUT, :out]]
      }
    }
  end
end
