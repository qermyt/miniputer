class DecimalZeroSource < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        zero0: HighSource,
        zero1: LowSource,
        zero2: LowSource,
        zero3: LowSource,
        zero4: LowSource,
        zero5: LowSource,
        zero6: LowSource,
        zero7: LowSource,
        zero8: LowSource,
        zero9: LowSource,
        out_converter: BitsToDecimal
      },
      connections: {
        [:zero0, :out] => [[:out_converter, 1]],
        [:zero1, :out] => [[:out_converter, 2]],
        [:zero2, :out] => [[:out_converter, 3]],
        [:zero3, :out] => [[:out_converter, 4]],
        [:zero4, :out] => [[:out_converter, 5]],
        [:zero5, :out] => [[:out_converter, 6]],
        [:zero6, :out] => [[:out_converter, 7]],
        [:zero7, :out] => [[:out_converter, 8]],
        [:zero8, :out] => [[:out_converter, 9]],
        [:zero9, :out] => [[:out_converter, 10]],
        [:out_converter, :out] => [[:OUT, :out]]
      }
    }
  end
end
