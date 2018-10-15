class NorLatch < CompositeComponent
  def self.blueprint
    {
      components: {
        left_or: OrGate,
        left_not: NotGate,
        right_or: OrGate,
        right_not: NotGate
      },
      connections: {
        [:IN, :set]        => [[:left_or,   :in1]],
        [:IN, :reset]      => [[:right_or,  :in1]],
        [:left_or, :out]   => [[:left_not,  :in1]],
        [:left_not, :out]  => [[:right_or,  :in2], [:OUT, :nq]],
        [:right_or, :out]  => [[:right_not, :in1]],
        [:right_not, :out] => [[:left_or,   :in2], [:OUT, :q]],
      }
    }
  end
end
