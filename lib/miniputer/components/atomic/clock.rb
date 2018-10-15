class Clock < AtomicComponent
  def initialize(_params = {})
    super
    PHYSICS.hook_up_clock(self)
  end

  def self.input_labels
    []
  end

  def self.output_labels
    [:out]
  end

  def tick
    @ticks += 1
    if @ticks >= CLOCK_HIGH_PULSE + CLOCK_LOW_PULSE
      @ticks = 0
    elsif @ticks >= CLOCK_HIGH_PULSE + CLOCK_LOW_PULSE - 2
      @output_wires[:out].set_value(LOW)
    elsif @ticks >= CLOCK_LOW_PULSE - 2
      @output_wires[:out].set_value(HIGH)
    end
  end

  def out(_ = nil)
    @output_wires[:out]
  end

  private

  def prepare_internals
    @ticks = 0
    super
  end

  def no_of_outputs
    1
  end

  def internal_perform
    out.set_value(!out.value)
  end
end
