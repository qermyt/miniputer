require 'spec_helper'

RSpec.describe AndGate do
  describe '#perform' do
    subject { described_class.build(in1: in1, in2: in2) }

    expectations = {
      { in1: L, in2: L } => { out: L },
      { in1: L, in2: H } => { out: L },
      { in1: H, in2: L } => { out: L },
      { in1: H, in2: H } => { out: H },
    }

    it_behaves_like 'a stateless component', expectations

  end
end
