require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe BitSelector do
  describe '#perform' do
    let!(:subject) { described_class.build }

    let(:out) { subject.out(:out).value }

    before do
      subject.in(:in1).set_value(input1)
      subject.in(:in2).set_value(input2)
      subject.in(:selector_bit).set_value(select)
    end

    describe '#run' do
      context 'with selector_wire LOW' do
        let(:select) { LOW }

        context 'with wire1 LOW' do
          let(:input1) { LOW }
          let(:input2) { HIGH }

          it 'selects wire 1' do
            subject.run
            expect(out).to eq LOW
          end
        end

        context 'with wire1 HIGH' do
          let(:input1) { HIGH }
          let(:input2) { LOW }

          it 'selects wire 1' do
            subject.run
            expect(out).to eq HIGH
          end
        end
      end

      context 'with selector_wire HIGH' do
        let(:select) { HIGH }

        context 'with wire2 LOW' do
          let(:input1) { HIGH }
          let(:input2) { LOW }

          it 'selects wire 2' do
            subject.run
            expect(out).to eq LOW
          end
        end

        context 'with wire2 HIGH' do
          let(:input1) { LOW }
          let(:input2) { HIGH }

          it 'selects wire 2' do
            subject.run
            expect(out).to eq HIGH
          end
        end
      end
    end
  end
end
