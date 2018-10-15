class ComponentBase
  attr_reader :x, :y

  attr_reader :input_wires
  attr_reader :output_wires
  attr_reader :super_component
  attr_reader :label

  def initialize(input_wires: {}, super_component: nil, label: nil)
    @super_component = super_component
    @label = label || self.class.to_s
    attach_input_wires(input_wires)
    prepare_internals
  end

  def run
    PHYSICS.run_until_stable
  end

  def super_components
    if @super_component
      @super_component.super_components << self
    else
      [self]
    end
  end

  def super_component_classes
    super_components.map(&:class)
  end

  def full_label
    super_components.map(&:label).join('.')
  end

  def attach_input_wires(wire_hash)
    (@input_wires ||= {}).merge!(wire_hash)
  end

  def attach_output_wires(wires)
    @output_wires = wires
  end

  def load
    @subcomponents.each(&:load)
  end

  def load_and_perform
    load
    perform
  end

  private

  def subcomponents
    []
  end

  def create_output_wires
    @output_wires = no_of_outputs.times.map { Wire.new }
  end

  def save_to_output_wires
    @output_wires.each_with_index { |w, i| w.set_value(@outputs[i]) }
  end
end
