RSpec.describe OrGate do
  describe '#perform' do
    subject { described_class.build(in1: in1, in2: in2) }

    expectations = {
      { in1: L, in2: L } => { out: L },
      { in1: L, in2: H } => { out: H },
      { in1: H, in2: L } => { out: H },
      { in1: H, in2: H } => { out: H },
    }

    it_behaves_like 'a stateless component', expectations

  end
end
