class EightBitBinaryToDecimal < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        eq: EightBitEqual,
        neq: NotGate,
        nset: NotGate,

        binary_goal: MemoryBlock,

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
        [:IN, :in_data] => [[:binary_goal, :in_data]],
        [:IN, :set] => [
          [:set_pulse, :in1],
          [:nset, :in1],
          #[:incr_gate2, :in2]
        ],

        [:eq, :out] => [[:neq, :in1]],
        [:dual_counter, :incr_done] => [[:n_incr_done, :in1]],

        [:set_pulse, :out] => [
          [:binary_goal, :save],
          [:dual_counter, :reset]
        ],

        [:binary_goal, :out] => [
          [:eq, :in_data1],
          [:OUT, :binary_goal]
        ],

        [:dual_counter, :bin_out] => [
          [:eq, :in_data2],
          [:OUT, :binary_counter]
        ],

        [:neq, :out] => [[:incr_gate, :in1]],
        [:n_incr_done, :out] => [[:incr_gate, :in2]],
        [:incr_gate, :out] => [[:incr_gate2, :in1]],
        [:nset, :out] => [[:incr_gate2, :in2]],
        [:incr_gate2, :out] => [[:dual_counter, :incr]],

        [:dual_counter, :dec_units] => [[:OUT, :units]],
        [:dual_counter, :dec_tens] => [[:OUT, :tens]],
        [:dual_counter, :dec_hundreds] => [[:OUT, :hundreds]]
      }
    }
  end
end
