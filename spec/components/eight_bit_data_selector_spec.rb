require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe EightBitDataSelector do
  describe '#perform' do
    let!(:subject) { described_class.build }

    let(:out) { subject.out(:out).bin_value }

    before do
      subject.in(:in_data1).set_bin_value('10010110')
      subject.in(:in_data2).set_bin_value('11001100')
      subject.in(:selector_bit).set_value(select)
    end

    describe '#run' do
      context 'with selector_wire LOW' do
        let(:select) { LOW }

        it 'selects wire 1' do
          subject.run
          expect(out).to eq '10010110'
        end
      end

      context 'with selector_wire HIGH' do
        let(:select) { HIGH }

        it 'selects wire 2' do
          subject.run
          expect(out).to eq '11001100'
        end
      end
    end
  end
end
