require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe EightBitIncrementor do
  describe '#perform' do
    let!(:subject) { described_class.build }

    let(:sum) { subject.sum.value }
    let(:carry) { subject.carry.value }

    describe '#run' do
      context 'with data input 23' do
        before { subject.in(:in_data).set_bin_value('00010111') }

        it 'returns 24' do
          subject.run
          expect(subject.out(:out).bin_value).to eq '00011000'
        end
      end
    end
  end
end
