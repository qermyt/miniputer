require 'singleton'

module Physics
  class TimeSimulator
    include Singleton

    def initialize
      @clocks = []
      @electric_flow = nil
    end

    def step(step_size = 1)
      step_size.times do
        @electric_flow.flow_all
        @clocks.each(&:tick)
      end
    end

    def go
      step until @electric_flow.stable?
    end

    def flow
      loop do
        go
        sleep(0.5)
      end
    end


    def hook_up_clock(clock)
      @clocks << clock
    end

    def hook_up_electric_flow(flow)
      @electric_flow = flow
    end
  end
end
