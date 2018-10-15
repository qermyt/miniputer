class BitSplitter < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        un_selecter_bit: NotGate,
        goto1: AndGate,
        goto2: AndGate
      },
      connections: {
        [:IN, :in1] => [[:goto1, :in1], [:goto2, :in1]],
        [:IN, :selecter_bit] =>
          [[:un_selecter_bit, :in1], [:goto2, :in2]],
        [:un_selecter_bit, :out] => [[:goto1, :in2]],
        [:goto1, :out] => [[:OUT, :out1]],
        [:goto2, :out] => [[:OUT, :out2]]
      }
    }
  end
end
