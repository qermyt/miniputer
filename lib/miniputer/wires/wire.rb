class Wire
  attr_reader :value
  attr_reader :upstream
  attr_reader :downstream_connections
  attr_reader :label

  def self.build(label)
    if label.to_s.include?('decimal')
      DecimalWire.new
    elsif label.to_s.include?('data') && !label.to_s.include?('bit')
      DataWire.new
    else
      Wire.new(label: label)
    end
  end

  def initialize(value = false, upstream: nil, label: nil)
    @upstream = upstream
    @downstream_connections = []
    @label = label
    set_value(value)
  end

  def inspect
    "<Wire:#{object_id}>"
  end

  def set_value(new_value)
    if @value != new_value
      @value = new_value
      PHYSICS.mark_as_flowing(self)
    end
  end

  def to_a
    [self]
  end

  def flip
    set_value(!@value)
  end

  def set_bin_value(b)
    set_value(!b.to_i.zero?)
  end

  def downstream
    cw_label = [upstream.label, wire.label]
    if upstream.attached?(cw_label)
      wire_component
    elsif comp.outgoing?(cw_label)
      comp.super_component.attach_wire(wire)
    end
  end

  def print_downstream_tree(prefix = '')
    @downstream_connections.each do |down_comp|
      puts "#{prefix}---#{down_comp.full_label}"
    end
    @downstream_connections.each do |down_comp|
      print_downstream_tree(down_comp.full_label)
    end
  end

  def flow
    @downstream_connections.each do |component|
      component.full_perform
    end
  end

  def attach(component)
    @downstream_connections << component
  end
end
