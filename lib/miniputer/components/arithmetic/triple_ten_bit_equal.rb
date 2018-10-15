class TripleTenBitEqual < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        dp1_equal: TenBitEqual,
        dp2_equal: TenBitEqual,
        dp3_equal: TenBitEqual,

        and1: AndGate,
        and2: AndGate
      },
      connections: {
        [:IN, :in_decimal_units1] => [[:dp1_equal, :in_decimal1]],
        [:IN, :in_decimal_units2] => [[:dp1_equal, :in_decimal2]],

        [:IN, :in_decimal_tens1] => [[:dp2_equal, :in_decimal1]],
        [:IN, :in_decimal_tens2] => [[:dp2_equal, :in_decimal2]],

        [:IN, :in_decimal_hundreds1] => [[:dp3_equal, :in_decimal1]],
        [:IN, :in_decimal_hundreds2] => [[:dp3_equal, :in_decimal2]],

        [:dp1_equal, :out] => [[:and1, :in1]],
        [:dp2_equal, :out] => [[:and1, :in2]],
        [:dp3_equal, :out] => [[:and2, :in1]],
        [:and1, :out] => [[:and2, :in2]],

        [:and2, :out] => [[:OUT, :out]]

      }
    }
  end
end
