RSpec.describe EightBitNegator do
  describe '#perform' do
    subject { described_class.build(in_data: in_data) }

    expectations = {
      {
        in_data:  [L, L, L, L, L, L, L, L]
      } => { out: [L, L, L, L, L, L, L, L] },

      {
        in_data:  [H, L, L, L, L, L, L, L]
      } => { out: [H, H, H, H, H, H, H, H] },

      {
        in_data:  [H, L, H, L, H, L, H, L]
      } => { out: [H, H, L, H, L, H, L, H] },

      {
        in_data:  [H, H, H, H, H, H, H, H]
      } => { out: [H, L, L, L, L, L, L, L] }

    }

    it_behaves_like 'a stateless component', expectations

  end
end
