class DualCounter < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        nset: NotGate,

        binary_counter: EightBitRegister,
        decimal_counter: ThreeDpRegister,

        bin_zero: ZeroSource,
        dec_zero: DecimalZeroSource,
        low: LowSource,
      },
      connections: {

        [:IN, :incr] => [
          [:binary_counter, :incr],
          [:decimal_counter, :incr]
        ],

        [:IN, :reset] => [
          [:binary_counter, :reset],
          [:decimal_counter, :reset]
        ],

        [:low, :out] => [
          [:binary_counter, :set],
          [:decimal_counter, :set]
        ],

        [:bin_zero, :out] => [[:binary_counter, :in_data]],
        [:dec_zero, :out] => [
          [:decimal_counter, :decimal_units],
          [:decimal_counter, :decimal_tens],
          [:decimal_counter, :decimal_hundreds]
        ],

        [:binary_counter, :out] => [[:OUT, :bin_out]],

        [:decimal_counter, :units] => [[:OUT, :dec_units]],
        [:decimal_counter, :tens] => [[:OUT, :dec_tens]],
        [:decimal_counter, :hundreds] => [[:OUT, :dec_hundreds]],

        [:binary_counter, :incr_done] => [[:OUT, :incr_done]]
      }
    }
  end
end
