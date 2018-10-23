class WireBundle
  attr_accessor :wires

  def initialize(*wires, label: nil)
    @wires = wires.empty? ? self.class.no_of_wires.times.map { Wire.new } : wires
  end

  def [](n)
    @wires[n]
  end

  def downstream_connections
    @wires.map(&:downstream_connections).flatten
  end

  def attach(component)
    @wires.each do |wire|
      wire.downstream_connections << component
    end
  end

  def set_value(*value)
    @wires.zip(value).each do |wire, v|
      wire.set_value(v)
    end
  end

  def set_bin_value(value)
    @wires.zip(value.split('').reverse).each do |wire, v|
      wire.set_value(!v.to_i.zero?)
    end
  end

  def set_dec_value(value)

  end

  def set_hex_value(value)

  end

  def value
    @wires.map { |wire| wire.value }
  end

  def bin_value
    @wires.map { |w| w.value ? '1' : '0' }.reverse.join
  end

  def dec_value

  end

  def hex_value

  end

  def to_a
    @wires
  end
end
