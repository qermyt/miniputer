RSpec.describe BitSelector do
  describe '#perform' do
    subject { described_class.build(in1: in1, in2: in2, selector_bit: selector_bit) }

    expectations = {
      { in1: L, in2: L, selector_bit: L } => { out: L },
      { in1: H, in2: L, selector_bit: L } => { out: H },
      { in1: L, in2: H, selector_bit: L } => { out: L },
      { in1: H, in2: H, selector_bit: L } => { out: H },
      { in1: L, in2: L, selector_bit: H } => { out: L },
      { in1: H, in2: L, selector_bit: H } => { out: L },
      { in1: L, in2: H, selector_bit: H } => { out: H },
      { in1: H, in2: H, selector_bit: H } => { out: H },

    }

    it_behaves_like 'a stateless component', expectations

  end
end
