require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe BitAdder do
  describe '#perform' do
    subject { described_class.build }

    let(:sum) { subject.out(:sum).value }
    let(:carry) { subject.out(:carry).value }

    before do
      subject.in(:bit1).set_value(input1)
      subject.in(:bit2).set_value(input2)
    end

    describe '#perform' do
      context 'with two LOW inputs' do
        let(:input1) { LOW }
        let(:input2) { LOW }

        it 'should return LOW' do
          subject.run
          expect(sum).to be LOW
          expect(carry).to be LOW
        end
      end

      context 'with one HIGH input' do
        let(:input1) { LOW }
        let(:input2) { HIGH }

        it 'should return 1' do
          subject.run
          expect(sum).to be HIGH
          expect(carry).to be LOW
        end
      end

      context 'with two HIGH input' do
        let(:input1) { HIGH }
        let(:input2) { HIGH }

        it 'should return 2' do
          subject.run
          expect(sum).to be LOW
          expect(carry).to be HIGH
        end
      end
    end
  end
end
