class EightBitNegator < CompositeComponent

  def out_data
    out(:out)
  end

  def self.blueprint
    {
      components: {
        in_bits: DataToBits,
        not1: NotGate,
        not2: NotGate,
        not3: NotGate,
        not4: NotGate,
        not5: NotGate,
        not6: NotGate,
        not7: NotGate,
        not8: NotGate,
        out_bits: BitsToData,
        plus_one: EightBitIncrementor
      },
      connections: {
        [:IN, :in_data] => [[:in_bits, :in_data]],
        [:in_bits, 1] => [[:not1, :in1]],
        [:in_bits, 2] => [[:not2, :in1]],
        [:in_bits, 3] => [[:not3, :in1]],
        [:in_bits, 4] => [[:not4, :in1]],
        [:in_bits, 5] => [[:not5, :in1]],
        [:in_bits, 6] => [[:not6, :in1]],
        [:in_bits, 7] => [[:not7, :in1]],
        [:in_bits, 8] => [[:not8, :in1]],

        [:not1, :out] => [[:out_bits, 1]],
        [:not2, :out] => [[:out_bits, 2]],
        [:not3, :out] => [[:out_bits, 3]],
        [:not4, :out] => [[:out_bits, 4]],
        [:not5, :out] => [[:out_bits, 5]],
        [:not6, :out] => [[:out_bits, 6]],
        [:not7, :out] => [[:out_bits, 7]],
        [:not8, :out] => [[:out_bits, 8]],

        [:out_bits, :out] => [[:plus_one, :in_data]],
        [:plus_one, :out] => [[:OUT, :out]]

      }
    }
  end
end
