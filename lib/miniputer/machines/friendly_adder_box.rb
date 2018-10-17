require_relative 'runnable'

class FriendlyAdderBox < Machine
  def self.build
    self.new(circuit: FriendlyAdderCircuit)
  end

  class FriendlyAdderCircuit < CompositeComponent

    private

    def bulbs
      @bulbs ||=
      {
        'SUM (HUNDREDS)' =>
        (0..9).map { |i| sub(:out_converter).out(:hundreds)[i] },
        'SUM (TENS)' =>
        (0..9).map { |i| sub(:out_converter).out(:tens)[i] },
        'SUM (UNITS)' =>
        (0..9).map { |i| sub(:out_converter).out(:units)[i] }

      }
    end

    def self.blueprint
      {
        components: {
          adder: FullAdder,
          in_converter1: DecimalToEightBitBinary,
          in_converter2: DecimalToEightBitBinary,
          in_converters_done: AndGate,

          out_converter_gate: AndGate,
          out_converter: EightBitBinaryToDecimal,

          decimal_zero: DecimalZeroSource
        },
        connections: {

          [:IN, :calculate] => [
            [:in_converter1, :set],
            [:in_converter2, :set],
            [:out_converter_gate, :in1]
          ],

          [:in_converter1, :done] => [[:in_converters_done, :in1]],
          [:in_converter2, :done] => [[:in_converters_done, :in2]],
          [:in_converters_done, :out] => [[:out_converter_gate, :in2]],

          [:out_converter_gate, :out] => [[:out_converter, :set]],

          [:IN, :in_decimal_tens1] =>
          [[:in_converter1, :in_decimal_tens]],
          [:IN, :in_decimal_units1] =>
          [[:in_converter1, :in_decimal_units]],

          [:IN, :in_decimal_tens2] =>
          [[:in_converter2, :in_decimal_tens]],
          [:IN, :in_decimal_units2] =>
          [[:in_converter2, :in_decimal_units]],


          [:decimal_zero, :out] => [
            [:in_converter1, :in_decimal_hundreds],
            [:in_converter2, :in_decimal_hundreds]
          ],

          [:in_converter1, :binary] => [[:adder, :in_data1]],
          [:in_converter2, :binary] => [[:adder, :in_data2]],

          [:adder, :data]  => [[:out_converter, :in_data]],

          [:out_converter, :units] => [[:OUT, :units]],
          [:out_converter, :tens] => [[:OUT, :tens]],
          [:out_converter, :hundreds] => [[:OUT, :hundreds]]

        }
      }
    end
  end
end
