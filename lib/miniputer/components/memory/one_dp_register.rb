class OneDpRegister < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        in_converter: DataToBits,

        set_selector0: BitSelector,
        set_selector1: BitSelector,
        set_selector2: BitSelector,
        set_selector3: BitSelector,
        set_selector4: BitSelector,
        set_selector5: BitSelector,
        set_selector6: BitSelector,
        set_selector7: BitSelector,
        set_selector8: BitSelector,
        set_selector9: BitSelector,

        reset_selector0: BitSelector,
        reset_selector1: BitSelector,
        reset_selector2: BitSelector,
        reset_selector3: BitSelector,
        reset_selector4: BitSelector,
        reset_selector5: BitSelector,
        reset_selector6: BitSelector,
        reset_selector7: BitSelector,
        reset_selector8: BitSelector,
        reset_selector9: BitSelector,

        d0: GatedLatch,
        d1: GatedLatch,
        d2: GatedLatch,
        d3: GatedLatch,
        d4: GatedLatch,
        d5: GatedLatch,
        d6: GatedLatch,
        d7: GatedLatch,
        d8: GatedLatch,
        d9: GatedLatch,

        save_path1: OrGate,
        save_path2: OrGate,
        save_gate: AndGate,
        incr_pulse: LongPulse,
        high: HighSource,
        low: LowSource,
        clock: Clock
      },
      connections: {

        [:IN, :set] => [
          [:set_selector0, :selector_bit],
          [:set_selector1, :selector_bit],
          [:set_selector2, :selector_bit],
          [:set_selector3, :selector_bit],
          [:set_selector4, :selector_bit],
          [:set_selector5, :selector_bit],
          [:set_selector6, :selector_bit],
          [:set_selector7, :selector_bit],
          [:set_selector8, :selector_bit],
          [:set_selector9, :selector_bit],
          [:save_path1, :in1]
        ],

        [:IN, :reset] => [
          [:reset_selector0, :selector_bit],
          [:reset_selector1, :selector_bit],
          [:reset_selector2, :selector_bit],
          [:reset_selector3, :selector_bit],
          [:reset_selector4, :selector_bit],
          [:reset_selector5, :selector_bit],
          [:reset_selector6, :selector_bit],
          [:reset_selector7, :selector_bit],
          [:reset_selector8, :selector_bit],
          [:reset_selector9, :selector_bit],
          [:save_path1, :in2]
        ],

        [:save_path1, :out] => [[:save_path2, :in1]],
        [:IN, :incr] => [[:incr_pulse, :in1]],
        [:incr_pulse, :out] => [[:save_path2, :in2]],
        [:save_path2, :out] => [[:save_gate, :in1]],
        [:clock, :out] => [[:save_gate, :in2]],

        [:save_gate, :out] => [
          [:d0, :gate],
          [:d1, :gate],
          [:d2, :gate],
          [:d3, :gate],
          [:d4, :gate],
          [:d5, :gate],
          [:d6, :gate],
          [:d7, :gate],
          [:d8, :gate],
          [:d9, :gate]
        ],

        [:IN, :in_d0] => [[:set_selector0, :in2]],
        [:IN, :in_d1] => [[:set_selector1, :in2]],
        [:IN, :in_d2] => [[:set_selector2, :in2]],
        [:IN, :in_d3] => [[:set_selector3, :in2]],
        [:IN, :in_d4] => [[:set_selector4, :in2]],
        [:IN, :in_d5] => [[:set_selector5, :in2]],
        [:IN, :in_d6] => [[:set_selector6, :in2]],
        [:IN, :in_d7] => [[:set_selector7, :in2]],
        [:IN, :in_d8] => [[:set_selector8, :in2]],
        [:IN, :in_d9] => [[:set_selector9, :in2]],

        [:set_selector0, :out] => [[:reset_selector0, :in1]],
        [:set_selector1, :out] => [[:reset_selector1, :in1]],
        [:set_selector2, :out] => [[:reset_selector2, :in1]],
        [:set_selector3, :out] => [[:reset_selector3, :in1]],
        [:set_selector4, :out] => [[:reset_selector4, :in1]],
        [:set_selector5, :out] => [[:reset_selector5, :in1]],
        [:set_selector6, :out] => [[:reset_selector6, :in1]],
        [:set_selector7, :out] => [[:reset_selector7, :in1]],
        [:set_selector8, :out] => [[:reset_selector8, :in1]],
        [:set_selector9, :out] => [[:reset_selector9, :in1]],


        [:high, :out] => [[:reset_selector0, :in2]],
        [:low, :out] => [
          [:reset_selector1, :in2],
          [:reset_selector2, :in2],
          [:reset_selector3, :in2],
          [:reset_selector4, :in2],
          [:reset_selector5, :in2],
          [:reset_selector6, :in2],
          [:reset_selector7, :in2],
          [:reset_selector8, :in2],
          [:reset_selector9, :in2]
        ],

        [:reset_selector0, :out] => [[:d0, :data_bit]],
        [:reset_selector1, :out] => [[:d1, :data_bit]],
        [:reset_selector2, :out] => [[:d2, :data_bit]],
        [:reset_selector3, :out] => [[:d3, :data_bit]],
        [:reset_selector4, :out] => [[:d4, :data_bit]],
        [:reset_selector5, :out] => [[:d5, :data_bit]],
        [:reset_selector6, :out] => [[:d6, :data_bit]],
        [:reset_selector7, :out] => [[:d7, :data_bit]],
        [:reset_selector8, :out] => [[:d8, :data_bit]],
        [:reset_selector9, :out] => [[:d9, :data_bit]],


        [:d0, :q] => [[:set_selector1, :in1], [:OUT, :d0]],
        [:d1, :q] => [[:set_selector2, :in1], [:OUT, :d1]],
        [:d2, :q] => [[:set_selector3, :in1], [:OUT, :d2]],
        [:d3, :q] => [[:set_selector4, :in1], [:OUT, :d3]],
        [:d4, :q] => [[:set_selector5, :in1], [:OUT, :d4]],
        [:d5, :q] => [[:set_selector6, :in1], [:OUT, :d5]],
        [:d6, :q] => [[:set_selector7, :in1], [:OUT, :d6]],
        [:d7, :q] => [[:set_selector8, :in1], [:OUT, :d7]],
        [:d8, :q] => [[:set_selector9, :in1], [:OUT, :d8]],
        [:d9, :q] => [[:set_selector0, :in1], [:OUT, :d9]]

      }
    }
  end
end
