class EightBitRegister < CompositeComponent
  def out_data
    @memory_block.out_data
  end

  private

  def self.blueprint
    {
      components: {
        zero: ZeroSource,
        mem: MemoryBlock,
        plus_one: EightBitIncrementor,
        plus_selector: EightBitDataSelector,
        set_selector: EightBitDataSelector,
        reset_selector: EightBitDataSelector,
        save: Clock,

        plus_pulse: LongPulse
      },
      connections: {
        [:IN, :in_data] =>
          [[:set_selector, :in_data2]],
        [:IN, :set] =>
          [[:set_selector, :selector_bit]],
        [:IN, :incr] =>
          [[:plus_pulse, :in1]],
        [:IN, :reset] =>
          [[:reset_selector, :selector_bit]],
        [:plus_selector, :out] =>
          [[:set_selector, :in_data1]],
        [:set_selector, :out] =>
          [[:reset_selector, :in_data1]],
        [:zero, :out] =>
          [[:reset_selector, :in_data2]],
        [:reset_selector, :out] =>
          [[:mem, :in_data]],
        [:save, :out] =>
          [[:mem, :save]],
        [:mem, :out] =>
          [[:plus_one, :in_data], [:plus_selector, :in_data1], [:OUT, :out]],
        [:plus_one, :out] =>
          [[:plus_selector, :in_data2]],

        [:plus_pulse, :out] => [[:plus_selector, :selector_bit]],
        [:plus_pulse, :done] => [[:OUT, :incr_done]]
      }
    }
  end
end
