class GatedLatch < CompositeComponent
  def q
    @latch.q
  end

  def nq
    @latch.nq
  end

  def self.blueprint
    {
      components: {
        n_data: NotGate,
        set: AndGate,
        reset: AndGate,
        latch: NorLatch
      },
      connections: {
        [:IN, :data_bit] => [[:n_data, :in1], [:set, :in1]],
        [:IN, :gate]     => [[:set, :in2], [:reset, :in2]],
        [:n_data, :out]  => [[:reset, :in1]],
        [:set, :out]     => [[:latch, :set]],
        [:reset, :out]   => [[:latch, :reset]],
        [:latch, :q]     => [[:OUT, :q]],
        [:latch, :nq]     => [[:OUT, :nq]],
      }
    }
  end
end
