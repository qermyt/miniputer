RSpec.describe BitAdder do
  describe '#perform' do
    subject { described_class.build(bit1: bit1, bit2: bit2) }

    expectations = {
      { bit1: L, bit2: L } => { sum: L, carry: L },
      { bit1: L, bit2: H } => { sum: H, carry: L },
      { bit1: H, bit2: L } => { sum: H, carry: L },
      { bit1: H, bit2: H } => { sum: L, carry: H },
    }

    it_behaves_like 'a stateless component', expectations

  end
end
