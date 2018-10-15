class BitEqual < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        both: AndGate,
        neither: AndGate,
        not1: NotGate,
        not2: NotGate,
        res: OrGate
      },
      connections: {
        [:IN, :in1] => [[:both, :in1], [:not1, :in1]],
        [:IN, :in2] => [[:both, :in2], [:not2, :in1]],
        [:not1, :out] => [[:neither, :in1]],
        [:not2, :out] => [[:neither, :in2]],
        [:both, :out] => [[:res, :in1]],
        [:neither, :out] => [[:res, :in2]],
        [:res, :out] => [[:OUT, :out]]
      }
    }

  end
end
