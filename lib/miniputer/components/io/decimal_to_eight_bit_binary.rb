class DecimalToEightBitBinary < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        eq: TripleTenBitEqual,
        neq: NotGate,

        decimal_goal: ThreeDpRegister,

        dual_counter: DualCounter,

        incr_gate: AndGate,
        incr_gate2: AndGate,
        n_incr_done: NotGate,
        zero: ZeroSource,
        dec_zero: DecimalZeroSource,
        low: LowSource,
        set_pulse: LongPulse
      },
      connections: {
        [:IN, :in_decimal_units] => [[:decimal_goal, :decimal_units]],
        [:IN, :in_decimal_tens] => [[:decimal_goal, :decimal_tens]],
        [:IN, :in_decimal_hundreds] => [[:decimal_goal, :decimal_hundreds]],

        [:IN, :set] => [
          [:set_pulse, :in1],
          [:incr_gate2, :in2]
        ],

        [:low, :out] => [
          [:decimal_goal, :reset],
          [:decimal_goal, :incr]
        ],

        [:eq, :out] => [[:neq, :in1], [:OUT, :done]],
        [:dual_counter, :incr_done] => [[:n_incr_done, :in1]],

        [:set_pulse, :out] => [
          [:decimal_goal, :set],
          [:dual_counter, :reset]
        ],

        [:decimal_goal, :units] => [
          [:eq, :in_decimal_units1],
          [:OUT, :decimal_goal_units]
        ],
        [:decimal_goal, :tens] => [
          [:eq, :in_decimal_tens1],
          [:OUT, :decimal_goal_tens]
        ],
        [:decimal_goal, :hundreds] => [
          [:eq, :in_decimal_hundreds1],
          [:OUT, :decimal_goal_hundreds]
        ],

        [:dual_counter, :dec_units] => [[:eq, :in_decimal_units2]],
        [:dual_counter, :dec_tens] => [[:eq, :in_decimal_tens2]],
        [:dual_counter, :dec_hundreds] => [[:eq, :in_decimal_hundreds2]],

        [:neq, :out] => [[:incr_gate, :in1]],
        [:n_incr_done, :out] => [[:incr_gate, :in2]],
        [:incr_gate, :out] => [[:incr_gate2, :in1]],
        [:incr_gate2, :out] => [[:dual_counter, :incr]],

        [:dual_counter, :bin_out] => [[:OUT, :binary]]
      }
    }
  end
end
