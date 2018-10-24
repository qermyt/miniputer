
RSpec.describe NorLatch do
  describe '#perform' do
    subject { described_class.build }

    before do
      subject.in(:set).set_value(input1)
      subject.in(:reset).set_value(input2)
    end

    let(:q) { subject.out(:q).value }
    let(:nq) { subject.out(:nq).value }

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
      context 'with two LOW inputs' do
        let(:input1) { LOW }
        let(:input2) { LOW }

        it 'latches' do
          subject
          expect_low

          subject.in(:reset).set_value(HIGH)
          expect_low

          subject.in(:reset).set_value(LOW)
          expect_low

          subject.in(:set).set_value(HIGH)
          expect_high

          subject.in(:set).set_value(LOW)
          expect_high

          subject.in(:reset).set_value(HIGH)
          expect_low
        end
      end
    end
  end
end
