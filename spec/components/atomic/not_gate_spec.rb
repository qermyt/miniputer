RSpec.describe NotGate do
  describe '#perform' do
    subject { described_class.build(in1: in1) }

    expectations = {
      { in1: L } => { out: H },
      { in1: H } => { out: L }
    }

    it_behaves_like 'a stateless component', expectations

  end
end
