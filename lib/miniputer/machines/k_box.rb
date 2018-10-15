require_relative 'composite_component'
require_all 'app/components/atomic'

class KBox < CompositeComponent
  attr_reader :mem1, :mem2, :out_mem

  def no_of_inputs
    3
  end

  def no_of_outputs
    1
  end

  def name
    'K-Box'
  end

  def sym_name
    'k_box'
  end

  def run
    25.times { PHYSICS.tick }
    clock_wire.set_value(HIGH)
    3.times { PHYSICS.tick } # Experimentally, this should be 3
    clock_wire.set_value(LOW)
    PHYSICS.run_until_stable
  end

  private

  def clock_wire
    wire([:clock, :out])
  end

  def blueprint
    {
      components: {
        clock: LowSource,
        save: HighSource,
        mem1: MemoryBlock,
        mem2: MemoryBlock,
        adder: FullAdder,
        out_mem: MemoryBlock
      },
      connections: {
        [:IN, :in1] => [[:mem1, :in_data]],
        [:IN, :in2] => [[:mem2, :in_data]],
        [:save, :out] => [[:mem1, :save], [:mem2, :save]],
        [:mem1, :out] => [[:adder, :in_data1]],
        [:mem2, :out] => [[:adder, :in_data2]],
        [:adder, :data] => [[:out_mem, :in_data]],
        [:clock, :out] => [[:out_mem, :save]],
        [:out_mem, :out] => [[:OUT, :out]]
      }
    }
  end

  def set_layout
    @or1.position = [2, 2]
    @or1.position = [2, 3]
  end
end
