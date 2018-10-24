RSpec.describe EightBitDataSelector do
  describe '#perform' do
    subject { described_class.build(in_data1: in_data1, in_data2: in_data2, selector_bit: selector_bit) }

    expectations = {
      {
        in_data1: [L, L, L, L, L, L, L, L],
        in_data2: [L, L, L, L, L, L, L, L],
        selector_bit: L
      } => { out: [L, L, L, L, L, L, L, L] },

      {
        in_data1: [H, H, H, H, L, L, L, L],
        in_data2: [L, L, L, L, H, H, H, H],
        selector_bit: L
      } => { out: [H, H, H, H, L, L, L, L] },

      {
        in_data1: [H, L, H, L, H, L, H, L],
        in_data2: [H, H, H, H, L, L, L, L],
        selector_bit: L
      } => { out: [H, L, H, L, H, L, H, L] },

      {
        in_data1: [L, L, L, L, L, L, L, L],
        in_data2: [L, L, L, L, L, L, L, L],
        selector_bit: H
      } => { out: [L, L, L, L, L, L, L, L] },

      {
        in_data1: [H, H, H, H, L, L, L, L],
        in_data2: [L, L, L, L, H, H, H, H],
        selector_bit: H
      } => { out: [L, L, L, L, H, H, H, H] },

      {
        in_data1: [H, L, H, L, H, L, H, L],
        in_data2: [H, H, H, H, L, L, L, L],
        selector_bit: H
      } => { out: [H, H, H, H, L, L, L, L] }

    }

    it_behaves_like 'a stateless component', expectations

  end
end
