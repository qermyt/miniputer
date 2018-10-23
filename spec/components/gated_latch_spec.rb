require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe GatedLatch do
  describe '#perform' do
    subject { described_class.build }

    let(:q) { subject.out(:q).value }
    let(:nq) { subject.out(:q).value }

    before do
      subject.in(:data_bit).set_value(data_input)
      subject.in(:gate).set_value(gate_input)
    end

    before(:each) { subject.run }

    def expect_low
      subject.run
      expect(subject.out(:q).value).to be LOW
      expect(subject.out(:nq).value).to be HIGH
    end

    def expect_high
      subject.run
      expect(subject.out(:q).value).to be HIGH
      expect(subject.out(:nq).value).to be LOW
    end

    describe '#perform' do
      context 'with no inputs' do
        let(:data_input) { LOW }
        let(:gate_input) { LOW }

        it 'starts off low' do
          expect_low
        end
      end

      context 'with LOW gate' do
        let(:data_input) { LOW }
        let(:gate_input) { LOW }

        it 'does not set/reset the latch' do
          subject.in(:data_bit).set_value(HIGH)
          expect_low

          subject.in(:data_bit).set_value(LOW)
          expect_low
        end

        it 'changes the gate input with no effect' do
          subject.in(:gate).set_value(HIGH)
          expect_low

          subject.in(:gate).set_value(LOW)
          expect_low
        end
      end

      context 'with HIGH gate' do
        let(:data_input) { LOW }
        let(:gate_input) { HIGH }

        it 'sets/resets the latch' do
          subject.in(:data_bit).set_value(HIGH)
          expect_high

          subject.in(:data_bit).set_value(LOW)
          expect_low
        end
      end
    end
  end
end
