class EightBitIncrementor < CompositeComponent

  private

  def self.blueprint
    {
      components: {
        adder1: BitAdder,
        adder2: BitAdder,
        adder3: BitAdder,
        adder4: BitAdder,
        adder5: BitAdder,
        adder6: BitAdder,
        adder7: BitAdder,
        adder8: BitAdder,
        one: HighSource,
        in_bits: DataToBits,
        out_bits: BitsToData
      },
      connections: {
        [:IN, :in_data] => [[:in_bits, :data_in]],

        [:in_bits, 1] => [[:adder1, :bit1]],
        [:in_bits, 2] => [[:adder2, :bit1]],
        [:in_bits, 3] => [[:adder3, :bit1]],
        [:in_bits, 4] => [[:adder4, :bit1]],
        [:in_bits, 5] => [[:adder5, :bit1]],
        [:in_bits, 6] => [[:adder6, :bit1]],
        [:in_bits, 7] => [[:adder7, :bit1]],
        [:in_bits, 8] => [[:adder8, :bit1]],

        [:one, :out]  => [[:adder1, :bit2]],
        [:adder1, :carry] => [[:adder2, :bit2]],
        [:adder2, :carry] => [[:adder3, :bit2]],
        [:adder3, :carry] => [[:adder4, :bit2]],
        [:adder4, :carry] => [[:adder5, :bit2]],
        [:adder5, :carry] => [[:adder6, :bit2]],
        [:adder6, :carry] => [[:adder7, :bit2]],
        [:adder7, :carry] => [[:adder8, :bit2]],

        [:adder1, :sum] => [[:out_bits, 1]],
        [:adder2, :sum] => [[:out_bits, 2]],
        [:adder3, :sum] => [[:out_bits, 3]],
        [:adder4, :sum] => [[:out_bits, 4]],
        [:adder5, :sum] => [[:out_bits, 5]],
        [:adder6, :sum] => [[:out_bits, 6]],
        [:adder7, :sum] => [[:out_bits, 7]],
        [:adder8, :sum] => [[:out_bits, 8]],

        [:out_bits, :out] => [[:OUT, :out]]
      }

    }
  end

  def jjinitialize_subcomponents
    @adders = []
    WORD_SIZE.times do |i|
      increment = i.zero? ? Wire.new(HIGH) : @adders[i-1].carry
      @adders << BitAdder.new(
        bit1: in_data[i], bit2: increment
      )
    end
  end
end
