require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe EightBitNegator do
  describe '#perform' do
    let!(:subject) do
      described_class.build
    end

    let(:data_wire) { DataWire.new }

    let(:sum) { subject.sum.value }
    let(:carry) { subject.carry.value }

    describe '#run' do
      context 'with data input 23' do
        before { subject.in(:in_data).set_bin_value('00010111') }

        it 'returns -23' do
          subject.run
          expect(subject.out_data.bin_value).to eq '11101001'
        end
      end
    end
  end
end
