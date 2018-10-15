require_relative 'wire_bundle'

class DataWire < WireBundle
  def self.no_of_wires
    WORD_SIZE
  end
end
