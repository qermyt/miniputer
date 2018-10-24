RSpec.describe FullAdder do
  describe '#perform' do
    subject { described_class.build(in_data1: in_data1, in_data2: in_data2) }

    expectations = {
      {
        in_data1:  [L, L, L, L, L, L, L, L],
        in_data2:  [L, L, L, L, L, L, L, L]
      } => { data: [L, L, L, L, L, L, L, L] },

      {
        in_data1:  [H, L, L, H, L, H, H, L],
        in_data2:  [L, L, L, L, L, L, L, L]
      } => { data: [H, L, L, H, L, H, H, L] },

      {
        in_data1:  [L, L, L, L, L, L, L, L],
        in_data2:  [L, H, H, L, H, L, L, H]
      } => { data: [L, H, H, L, H, L, L, H] },

      {
        in_data1:  [H, L, L, L, L, L, L, L],
        in_data2:  [H, L, L, L, L, L, L, L]
      } => { data: [L, H, L, L, L, L, L, L] },

      {
        in_data1:  [H, L, H, L, H, L, H, L],
        in_data2:  [H, H, L, H, L, H, L, L]
      } => { data: [L, L, L, L, L, L, L, H] },

      {
        in_data1:  [L, L, L, L, L, L, L, H],
        in_data2:  [L, L, L, L, L, L, L, H]
      } => { data: [L, L, L, L, L, L, L, L] },

    }

    it_behaves_like 'a stateless component', expectations

  end
end
