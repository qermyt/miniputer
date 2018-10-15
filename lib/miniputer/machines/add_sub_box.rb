class AddSubBox < Machine
  def self.build
    self.new(circuit: AddSubCircuit)
  end


  class AddSubCircuit < CompositeComponent
    private

    def self.blueprint
      {
        components: {
          adder: FullAdder,
          neg: EightBitNegator,
          operand_joiner: EightBitDataSelector
        },
        connections: {
          [:IN, :in_data1] => [[:adder, :in_data1]],
          [:IN, :in_data2] => [[:operand_joiner, :in_data1], [:neg, :in_data]],
          [:IN, :operation] => [[:operand_joiner, :selector_bit]],
          [:neg, :out] => [[:operand_joiner, :in_data2]],
          [:operand_joiner, :out] => [[:adder, :in_data2]],
          [:adder, :data] => [[:OUT, :out]]
        }
      }
    end
  end
end
