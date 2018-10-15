require_relative 'runnable'

class AdderBox < CompositeComponent
  include Runnable

  private

  def bulbs
    @bulbs ||=
    {
      'FIRST NUMBER' =>
      (0..7).map { |i| @input_wires[:in_data1][i] }.reverse,
      'SECOND NUMBER' =>
      (0..7).map { |i| @input_wires[:in_data2][i] }.reverse,
      'SUM' =>
      (0..7).map { |i| sub(:adder).out(:data)[i] }.reverse
    }
  end

  def display_switches
    {
      'FIRST NUMBER' =>
      (0..7).map { |i| @input_wires[:in_data1][i] }.reverse,
      'SECOND NUMBER' =>
      (0..7).map { |i| @input_wires[:in_data2][i] }.reverse,
    }
  end

  def self.blueprint
    {
      components: { adder: FullAdder },
      connections: {
        [:IN, :in_data1] => [[:adder, :in_data1]],
        [:IN, :in_data2] => [[:adder, :in_data2]],
        [:adder, :data]  => [[:OUT, :out]]
      }
    }
  end
end

a_params = 8.times.map do |i|
  ["a#{i}".to_sym, Wire.new]
end.to_h
b_params = 8.times.map do |i|
  ["b#{i}".to_sym, Wire.new]
end.to_h

#AdderBox.new(a_params.merge(b_params)).irun
#AdderBox.build.irun
