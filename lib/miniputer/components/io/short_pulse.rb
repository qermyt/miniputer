class ShortPulse < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        clock: Clock,
        nclock: NotGate,
        first_pulse: NorLatch,
        pulse_blocker: NorLatch,
        set_pulse_blocker: AndGate,
        pulse_gate: AndGate,
        pulse: AndGate,
        reset: NotGate
      },
      connections: {
        [:IN, :in1] => [[:pulse, :in1], [:reset, :in1]],
        [:clock, :out] => [[:pulse_gate, :in1], [:nclock, :in1], [:OUT, :_clock]],
        [:pulse_blocker, :nq] => [[:pulse_gate, :in2]],
        [:pulse_gate, :out] => [[:pulse, :in2]],

        [:pulse, :out] => [[:first_pulse, :set], [:OUT, :out]],
        [:first_pulse, :q] => [[:set_pulse_blocker, :in1]],
        [:nclock, :out] => [[:set_pulse_blocker, :in2]],
        [:set_pulse_blocker, :out] => [[:pulse_blocker, :set]],

        [:reset, :in1] => [
          [:first_pulse, :reset], [:pulse_blocker, :reset]
        ]
      }
    }
  end
end
