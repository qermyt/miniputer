require_relative 'component_base'

class CompositeComponent < ComponentBase
  def self.build(wire_values = {})
    self.new(
      input_wires: build_input_wires(wire_values)
    ).tap(&:connect_wires)
  end

  def self.build_input_wires(wire_values)
    input_labels.map { |label|
      [label, Wire.build(label, value: wire_values[label] || LOW)]
    }.to_h
  end

  def self.input_labels
    sources.select { |from, _| from == :IN  }.map(&:last)
  end

  def self.output_labels
    sinks.select   { |to,   _| to   == :OUT }.map(&:last)
  end

  def self.sources
    blueprint[:connections].keys
  end

  def self.sinks
    blueprint[:connections].values.shallow_flatten
  end

  def initialize_subcomponents

    @subcomponents =
      self.class.blueprint[:components].transform_values do |label, klass|
      klass.new(super_component: self, label: label)
    end
  end

  def output_wires
    self.class.output_labels.map do |label|
      [label, out(label)]
    end.to_h
  end

  def load
    @subcomponents.each(&:load)
  end

  def full_perform
    perform
  end

  def perform
    @subcomponents.each(&:full_perform)
  end

  def sub(label)
    label == :IN ? self : @subcomponents[label]
  end

  def to_s
    full_label
  end

  def inspect
    full_label
  end

  def connect_wires
    self.class.blueprint[:connections].each do |source, _|
      connect_wire(source)
    end

    (@subcomponents.values).each(&:connect_wires)
  end

  def in(wire_label)
    @input_wires[wire_label]
  end

  def out(wire_label)
    wire(source_from_sink([:OUT, wire_label]))
  end

  def wire(source)
    if source.first == :IN
      wire = @input_wires[source.last]

      raise "#{self}: no input #{source.last}" if wire.nil?
      wire
    else
      raise "#{self}: Nosub #{source.first}" if sub(source.first).nil?
      sub(source.first).out(source.last)
    end
  end

  def wire_from_sink(sink)
    wire(source_from_sink(sink))
  end


  def attach_wire(wire, source)
    if source.first == :IN
      @input_wires[source.last] ||= wire
    end

    raise "#{self}: #{source} has no sinks" if sinks_from_source(source).nil?
    sinks_from_source(source).each do |sink|
      next if sink.first == :OUT
      raise "#{self}: No sub #{sink.first}" if sub(sink.first).nil?
      sub(sink.first).attach_wire(wire, [:IN, sink.last])
    end
  end

  private

  def sinks_from_source(source)
    self.class.blueprint[:connections][source]
  end

  def source_from_sink(sink)
    x = self.class.blueprint[:connections].find do |source, sinks|
      sinks.include?(sink)
    end
    raise "#{self}: Nothing such sink as #{sink}" if x.nil?
    x.first
  end

  def connect_wire(source)
    attach_wire(wire(source), source)
  end

  def downstream(wire_label)
    self.class.sinks.find do |config|
      config.second.values.include?(cw_label)
    end
  end

  def prepare_internals
    initialize_subcomponents
  end
end
