require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe OrGate do
  describe '#perform' do
    subject { OrGate.new(input_wires: { in1: wire1, in2: wire2 }) }

    let(:wire1) { Wire.new(input1) }
    let(:wire2) { Wire.new(input2) }
    let(:out) { subject.out.value }

    describe '#full_perform' do
      context 'with two LOW inputs' do
        let(:input1) { LOW }
        let(:input2) { LOW }

        it 'should return LOW' do
          subject.full_perform
          expect(out).to be LOW
        end
      end

      context 'with one HIGH input' do
        let(:input1) { LOW }
        let(:input2) { HIGH }

        it 'should pass' do
          subject.full_perform
          expect(out).to be HIGH
        end
      end

      context 'with two HIGH input' do
        let(:input1) { HIGH }
        let(:input2) { HIGH }

        it 'should pass' do
          subject.full_perform
          expect(out).to be HIGH
        end
      end
    end
  end
end
