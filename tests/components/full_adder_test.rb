require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe FullAdder do
  describe '#perform' do
    let!(:subject) { described_class.build }

    before do
      (1..8).each do |i|
        subject.in(:in_data1)[i-1].set_value(send("input#{i}"))
        subject.in(:in_data2)[i-1].set_value(send("input#{i+8}"))
      end
    end

    describe '#perform' do
      context 'without overflow' do
        let(:input1) { HIGH }
        let(:input2) { HIGH }
        let(:input3) { LOW }
        let(:input4) { LOW }
        let(:input5) { HIGH }
        let(:input6) { HIGH }
        let(:input7) { LOW }
        let(:input8) { LOW }

        let(:input9)  { HIGH }
        let(:input10) { LOW }
        let(:input11) { HIGH }
        let(:input12) { LOW }
        let(:input13) { HIGH }
        let(:input14) { HIGH }
        let(:input15) { LOW }
        let(:input16) { LOW }

        it 'uses the TransientWireQueue' do
          subject.run
          expect(subject.out(:data).value).to(
            eq(
              [
                LOW,
                LOW,
                LOW,
                HIGH,
                LOW,
                HIGH,
                HIGH,
                LOW
              ]
            )
          )
        end

        it '5 - 2 = 3' do
          subject.run

          subject.wire([:IN, :in_data1]).set_bin_value('00000101')
          subject.wire([:IN, :in_data2]).set_bin_value('11111110')
          subject.run

          expect(subject.out(:data).bin_value).to eq '00000011'
        end
      end

      context 'with overflow' do
        let(:input1) { HIGH }
        let(:input2) { HIGH }
        let(:input3) { LOW }
        let(:input4) { LOW }
        let(:input5) { HIGH }
        let(:input6) { HIGH }
        let(:input7) { LOW }
        let(:input8) { LOW }

        let(:input9)  { HIGH }
        let(:input10) { LOW }
        let(:input11) { HIGH }
        let(:input12) { LOW }
        let(:input13) { HIGH }
        let(:input14) { HIGH }
        let(:input15) { HIGH }
        let(:input16) { HIGH }

        it '51 + 245 = 40 (296 mod 256)' do
          subject.run
          expect(subject.out(:data).value).to(
            eq(
              [
                LOW,
                LOW,
                LOW,
                HIGH,
                LOW,
                HIGH,
                LOW,
                LOW
              ]
            )
          )
        end
      end
    end
  end
end
