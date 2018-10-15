module Physics
  class Simulator
    def initialize
      @clocks = []
      @electric_flow = ElectricFlow.new
    end

    def flow_size
      @electric_flow.wireflow.size
    end

    def hook_up_clock(clock)
      @clocks << clock
    end

    def hook_up_electric_flow(flow)
      @electric_flow = flow
    end

    def tick
      @clocks.each(&:tick)
      @electric_flow.flow_all
    end

    def run_until_stable
      tick until @electric_flow.stable?
    end

    def run_one_clock_tick
      (CLOCK_HIGH_PULSE + CLOCK_LOW_PULSE).times { tick }
    end

    def run_until_clock_stable
      loop do
        (CLOCK_HIGH_PULSE + CLOCK_LOW_PULSE).times { tick }
        break if @electric_flow.stable?
      end
    end

    def mark_as_flowing(wire)
      @electric_flow.mark_as_flowing(wire)
    end

    def equilibrium?
      @electric_flow.stable?
    end
  end
end
