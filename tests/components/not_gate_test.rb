require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe NotGate do
  describe '#perform' do
    subject { NotGate.new(input_wires: { in1: wire }) }

    let(:wire) { Wire.new(input) }
    let(:out) { subject.out.value }

    describe '#full_perform' do
      context 'with LOW input' do
        let(:input) { LOW }

        it 'should return HIGH' do
          subject.full_perform
          expect(out).to be HIGH
        end
      end

      context 'with HIGH input' do
        let(:input) { HIGH }

        it 'should pass' do
          subject.full_perform
          expect(out).to be LOW
        end
      end
    end
  end
end
