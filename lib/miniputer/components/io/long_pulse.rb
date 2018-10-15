class LongPulse < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        n_in: NotGate,
        clock: Clock,
        nclock: NotGate,

        ready_state: NorLatch,
        prepulse_gate: AndGate,
        prepulse_state: NorLatch,
        low_pulse_gate: AndGate,
        low_pulse_state: NorLatch,
        high_pulse_gate: AndGate,
        high_pulse_state: NorLatch,
        pulse_gate: AndGate,
        block_pulse_gate: AndGate,
        allow_pulse_state: NorLatch
      },


      # Default state:
      # IN: state -> ready

      # ready:
      # clock on: 1 -> prepulse

      # prepulse:
      # clock off: 1 -> pulse-noclock

      # low_pulse:
      # clock on: 1 -> pulse-clock

      # high_pulse:
      # clock off: 0 -> allow_pulse

      # low_pulse = 1 && allow_pulse = 1: PULSE
      # !IN: 0 -> all states, 1 -> allow_pulse

      connections: {
        [:IN, :in1] => [[:ready_state, :set], [:n_in, :in1]],
        [:n_in, :out] => [
          [     :ready_state, :reset],
          [  :prepulse_state, :reset],
          [ :low_pulse_state, :reset],
          [:high_pulse_state, :reset],
          [:allow_pulse_state, :set]
        ],
        [:clock, :out] => [
          [:nclock, :in1],
          [:prepulse_gate, :in2],
          [:high_pulse_gate, :in2]
        ],
        [:nclock, :out] => [
          [:low_pulse_gate, :in2],
          [:block_pulse_gate, :in2]
        ],


        [:ready_state, :q] => [[:prepulse_gate, :in1]],
        [:prepulse_gate, :out] => [[:prepulse_state, :set]],

        [:prepulse_state, :q] => [[:low_pulse_gate, :in1]],
        [:low_pulse_gate, :out] => [[:low_pulse_state, :set]],

        [:low_pulse_state, :q] => [
          [:high_pulse_gate, :in1],
          [:pulse_gate, :in1],
        ],
        [:high_pulse_gate, :out] => [[:high_pulse_state, :set]],

        [:high_pulse_state, :q] => [[:block_pulse_gate, :in1]],
        [:block_pulse_gate, :out] => [[:allow_pulse_state, :reset]],

        [:allow_pulse_state, :q] => [[:pulse_gate, :in2]],
        [:allow_pulse_state, :nq] => [[:OUT, :done]],
        [:pulse_gate, :out] => [[:OUT, :out]]

      }
    }
  end
end
