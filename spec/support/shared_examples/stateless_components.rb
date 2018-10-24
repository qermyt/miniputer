RSpec.shared_examples "a stateless component" do |expectations|
  expectations.each do |inputs, expected_outputs|
    context "with input #{inputs}" do

      inputs.each do |label, value|
        let(label) { value }
      end

      it "return output #{expected_outputs}" do
        subject.run

        expected_outputs.each do |label, expected_value|
          expect(subject.out(label).value).to eq expected_value
        end

      end
    end
  end
end
