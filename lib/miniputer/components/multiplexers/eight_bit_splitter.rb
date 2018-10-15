class  EightBitSplitter < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        in_converter: DataToBits,
        splitter1: BitSplitter,
        splitter2: BitSplitter,
        splitter3: BitSplitter,
        splitter4: BitSplitter,
        splitter5: BitSplitter,
        splitter6: BitSplitter,
        splitter7: BitSplitter,
        splitter8: BitSplitter,
        out_converter1: BitsToData,
        out_converter2: BitsToData
      },
      connections: {
        [:IN, :in_data] => [[:in_converter, :in1]],
        [:IN, :selecter_bit] => [
          [:splitter1, :selecter_bit],
          [:splitter2, :selecter_bit],
          [:splitter3, :selecter_bit],
          [:splitter4, :selecter_bit],
          [:splitter5, :selecter_bit],
          [:splitter6, :selecter_bit],
          [:splitter7, :selecter_bit],
          [:splitter8, :selecter_bit]
        ],

        [:in_converter, 1] => [[:splitter1, :in1]],
        [:in_converter, 2] => [[:splitter2, :in1]],
        [:in_converter, 3] => [[:splitter3, :in1]],
        [:in_converter, 4] => [[:splitter4, :in1]],
        [:in_converter, 5] => [[:splitter5, :in1]],
        [:in_converter, 6] => [[:splitter6, :in1]],
        [:in_converter, 7] => [[:splitter7, :in1]],
        [:in_converter, 8] => [[:splitter8, :in1]],

        [:splitter1, :out1] => [[:out_converter1, 1]],
        [:splitter2, :out1] => [[:out_converter1, 2]],
        [:splitter3, :out1] => [[:out_converter1, 3]],
        [:splitter4, :out1] => [[:out_converter1, 4]],
        [:splitter5, :out1] => [[:out_converter1, 5]],
        [:splitter6, :out1] => [[:out_converter1, 6]],
        [:splitter7, :out1] => [[:out_converter1, 7]],
        [:splitter8, :out1] => [[:out_converter1, 8]],

        [:splitter1, :out2] => [[:out_converter2, 1]],
        [:splitter2, :out2] => [[:out_converter2, 2]],
        [:splitter3, :out2] => [[:out_converter2, 3]],
        [:splitter4, :out2] => [[:out_converter2, 4]],
        [:splitter5, :out2] => [[:out_converter2, 5]],
        [:splitter6, :out2] => [[:out_converter2, 6]],
        [:splitter7, :out2] => [[:out_converter2, 7]],
        [:splitter8, :out2] => [[:out_converter2, 8]],

        [:out_converter1, :out] => [[:OUT, :out1]],
        [:out_converter2, :out] => [[:OUT, :out2]],
      }
    }

  end
end
