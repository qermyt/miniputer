require_relative '../test_helper'
require 'yaml'

RSpec.describe BlueprintTranslater do
  let(:template_filename) { 'tests/templates/bit_adder_blueprint.yml' }
  let(:yaml_blueprint) { File.read(template_filename) }

  describe '.class_to_yml' do
    it 'should translate a component blueprint' do

      File.open('yml_test.yml', 'w') do |file|
        file.write described_class.class_to_yml(BitAdder).to_yaml
      end

      expect(
        described_class.class_to_yml(BitAdder).to_yaml
      ).to eq yaml_blueprint
    end
  end

  describe '.yml_to_blueprint' do
    it 'translates a yml hash into a blueprint' do
      yml = YAML.load_file(template_filename)
      expect(described_class.yml_to_blueprint(yml)).to eq(BitAdder.blueprint)
    end
  end
end
