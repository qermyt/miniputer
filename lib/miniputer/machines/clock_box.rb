#require_relative '../../application'
require_relative 'runnable'

class ClockBox < CompositeComponent
  include Runnable

  private

  def bulbs
    @bulbs ||= {
      'CLOCK' => [sub(:clock).out(:out)],
      'MEM' => sub(:mem).out(:out).wires,
      'PLUS' => sub(:plus).out(:out).wires,
    }
  end

  def display_switches
    {}
  end

  def self.blueprint
    {
      components: {
        clock: Clock,
        mem: MemoryBlock,
        plus: EightBitIncrementor,
        plus_mem: MemoryBlock,
        always_save: HighSource
      },
      connections: {
        [:clock, :out] => [[:mem, :save]],
        [:mem, :out]   => [[:plus, :in_data]],
        [:plus, :out]  => [[:plus_mem, :in_data]],
        [:always_save, :out] => [[:plus_mem, :save]],
        [:plus_mem, :out]  => [[:mem, :in_data]]
      }
    }
  end
end
