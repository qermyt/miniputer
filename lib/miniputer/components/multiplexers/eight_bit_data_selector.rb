class EightBitDataSelector < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        in_converter1: DataToBits,
        in_converter2: DataToBits,
        bit_selector1: BitSelector,
        bit_selector2: BitSelector,
        bit_selector3: BitSelector,
        bit_selector4: BitSelector,
        bit_selector5: BitSelector,
        bit_selector6: BitSelector,
        bit_selector7: BitSelector,
        bit_selector8: BitSelector,
        out_converter: BitsToData
      },

      connections: {
        [:IN, :in_data1] => [[:in_converter1, :data_in]],
        [:IN, :in_data2] => [[:in_converter2, :data_in]],
        [:IN, :selector_bit] => [
          [:bit_selector1, :selector_bit],
          [:bit_selector2, :selector_bit],
          [:bit_selector3, :selector_bit],
          [:bit_selector4, :selector_bit],
          [:bit_selector5, :selector_bit],
          [:bit_selector6, :selector_bit],
          [:bit_selector7, :selector_bit],
          [:bit_selector8, :selector_bit]
        ],

        [:in_converter1, 1] => [[:bit_selector1, :in1]],
        [:in_converter1, 2] => [[:bit_selector2, :in1]],
        [:in_converter1, 3] => [[:bit_selector3, :in1]],
        [:in_converter1, 4] => [[:bit_selector4, :in1]],
        [:in_converter1, 5] => [[:bit_selector5, :in1]],
        [:in_converter1, 6] => [[:bit_selector6, :in1]],
        [:in_converter1, 7] => [[:bit_selector7, :in1]],
        [:in_converter1, 8] => [[:bit_selector8, :in1]],

        [:in_converter2, 1] => [[:bit_selector1, :in2]],
        [:in_converter2, 2] => [[:bit_selector2, :in2]],
        [:in_converter2, 3] => [[:bit_selector3, :in2]],
        [:in_converter2, 4] => [[:bit_selector4, :in2]],
        [:in_converter2, 5] => [[:bit_selector5, :in2]],
        [:in_converter2, 6] => [[:bit_selector6, :in2]],
        [:in_converter2, 7] => [[:bit_selector7, :in2]],
        [:in_converter2, 8] => [[:bit_selector8, :in2]],

        [:bit_selector1, :out] => [[:out_converter, 1]],
        [:bit_selector2, :out] => [[:out_converter, 2]],
        [:bit_selector3, :out] => [[:out_converter, 3]],
        [:bit_selector4, :out] => [[:out_converter, 4]],
        [:bit_selector5, :out] => [[:out_converter, 5]],
        [:bit_selector6, :out] => [[:out_converter, 6]],
        [:bit_selector7, :out] => [[:out_converter, 7]],
        [:bit_selector8, :out] => [[:out_converter, 8]],

        [:out_converter, :out] => [[:OUT, :out]]
      }
    }
  end
end
