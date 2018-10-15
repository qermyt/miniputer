class TenBitEqual < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        in_converter1: DataToBits,
        in_converter2: DataToBits,
        eq1: BitEqual,
        eq2: BitEqual,
        eq3: BitEqual,
        eq4: BitEqual,
        eq5: BitEqual,
        eq6: BitEqual,
        eq7: BitEqual,
        eq8: BitEqual,
        eq9: BitEqual,
        eq10: BitEqual,

        and11: AndGate,
        and12: AndGate,
        and13: AndGate,
        and14: AndGate,
        and15: AndGate,

        and21: AndGate,
        and22: AndGate,
        and23: AndGate,

        and31: AndGate,
      },
      connections: {
        [:IN, :in_decimal1] => [[:in_converter1, :data_in]],
        [:IN, :in_decimal2] => [[:in_converter2, :data_in]],

        [:in_converter1, 1] => [[:eq1, :in1]],
        [:in_converter1, 2] => [[:eq2, :in1]],
        [:in_converter1, 3] => [[:eq3, :in1]],
        [:in_converter1, 4] => [[:eq4, :in1]],
        [:in_converter1, 5] => [[:eq5, :in1]],
        [:in_converter1, 6] => [[:eq6, :in1]],
        [:in_converter1, 7] => [[:eq7, :in1]],
        [:in_converter1, 8] => [[:eq8, :in1]],
        [:in_converter1, 9] => [[:eq9, :in1]],
        [:in_converter1, 10] => [[:eq10, :in1]],

        [:in_converter2, 1] => [[:eq1, :in2]],
        [:in_converter2, 2] => [[:eq2, :in2]],
        [:in_converter2, 3] => [[:eq3, :in2]],
        [:in_converter2, 4] => [[:eq4, :in2]],
        [:in_converter2, 5] => [[:eq5, :in2]],
        [:in_converter2, 6] => [[:eq6, :in2]],
        [:in_converter2, 7] => [[:eq7, :in2]],
        [:in_converter2, 8] => [[:eq8, :in2]],
        [:in_converter2, 9] => [[:eq9, :in2]],
        [:in_converter2, 10] => [[:eq10, :in2]],

        [:eq1, :out] => [[:and11, :in1]],
        [:eq2, :out] => [[:and11, :in2]],
        [:eq3, :out] => [[:and12, :in1]],
        [:eq4, :out] => [[:and12, :in2]],
        [:eq5, :out] => [[:and13, :in1]],
        [:eq6, :out] => [[:and13, :in2]],
        [:eq7, :out] => [[:and14, :in1]],
        [:eq8, :out] => [[:and14, :in2]],
        [:eq9, :out] => [[:and15, :in1]],
        [:eq10, :out] => [[:and15, :in2]],

        [:and11, :out] => [[:and21, :in1]],
        [:and12, :out] => [[:and21, :in2]],
        [:and13, :out] => [[:and22, :in1]],
        [:and14, :out] => [[:and22, :in2]],
        [:and15, :out] => [[:and23, :in2]],

        [:and21, :out] => [[:and31, :in1]],
        [:and22, :out] => [[:and23, :in1]],
        [:and23, :out] => [[:and31, :in2]],

        [:and31, :OUT] => [[:OUT, :out]]
      }
    }
  end
end
