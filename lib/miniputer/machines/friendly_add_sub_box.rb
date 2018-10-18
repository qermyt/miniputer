require_relative 'runnable'

class FriendlyAddSubBox < Machine
  def self.build
    self.new(circuit: FriendlyAddSubCircuit)
  end

  def switches
    {
      '00 10 20 30 40 50 60 70 80 90 (First number)' =>
        @circuit.input_wires[:in_decimal_tens1].to_a,
      ' 0  1  2  3  4  5  6  7  8  9 (First number)' =>
        @circuit.input_wires[:in_decimal_units1].to_a,
      '00 10 20 30 40 50 60 70 80 90 (Second number)' =>
        @circuit.input_wires[:in_decimal_tens2].to_a,
      ' 0  1  2  3  4  5  6  7  8  9 (Second number)' =>
        @circuit.input_wires[:in_decimal_units2].to_a,

      "'|' = PLUS    '/' = MINUS" =>
        @circuit.input_wires[:operation].to_a,
      "PRESS TWICE TO CALCULATE" =>
        @circuit.input_wires[:calculate].to_a,
    }
  end

  def bulbs
    @bulbs ||=
    {
      ' 0 100 200 300 400 500 600 700 800 900' =>
      (0..9).map { |i| @circuit.sub(:out_converter).out(:hundreds)[i] },
      '00  10  20  30  40  50  60  70  80  90' =>
      (0..9).map { |i| @circuit.sub(:out_converter).out(:tens)[i] },
      ' 0   1   2   3   4   5   6   7   8   9' =>
      (0..9).map { |i| @circuit.sub(:out_converter).out(:units)[i] }

    }
  end


  class FriendlyAddSubCircuit < CompositeComponent

    private

    def self.blueprint
      {
        components: {
          adder: FullAdder,
          in_converter1: DecimalToEightBitBinary,
          in_converter2: DecimalToEightBitBinary,
          in_converters_done: AndGate,

          neg: EightBitNegator,
          operand_joiner: EightBitDataSelector,

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

          [:IN, :operation] => [[:operand_joiner, :selector_bit]],

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
          #[:in_converter2, :binary] => [[:adder, :in_data2]],

          [:in_converter2, :binary] => [
            [:operand_joiner, :in_data1],
            [:neg, :in_data]
          ],
          [:neg, :out] => [[:operand_joiner, :in_data2]],
          [:operand_joiner, :out] => [[:adder, :in_data2]],

          [:adder, :data]  => [[:out_converter, :in_data]],

          [:out_converter, :units] => [[:OUT, :units]],
          [:out_converter, :tens] => [[:OUT, :tens]],
          [:out_converter, :hundreds] => [[:OUT, :hundreds]]

        }
      }
    end
  end
end
