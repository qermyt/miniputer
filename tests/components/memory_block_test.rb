require 'rspec'
require_relative '../test_helper'
require 'byebug'

RSpec.describe MemoryBlock do
  describe '#perform' do
    subject { described_class.build }

    let(:data_wire) { subject.in(:in_data) }
    let(:save_wire) { subject.in(:save) }

    context 'with HIGH save gate' do
      it 'saves the value to the latches' do
        subject.run

        data_wire.set_bin_value('01101001')

        subject.run
        expect(subject.out(:out).value).to(
          eq(Array.new(8, LOW))
        )

        save_wire.set_value(HIGH)
        subject.run

        expect(subject.out(:out).value).to(
          eq([HIGH, LOW, LOW, HIGH, LOW, HIGH, HIGH, LOW])
        )
      end
    end
  end
end
