class MemoryBlock < CompositeComponent
  attr_reader :memory_cells

  def memory_cells_outs
    (1..WORD_SIZE).each.map { |i| sub("memory_cell_#{i}").out(:q) }
  end

  def self.blueprint
    comps =
      (1..WORD_SIZE).map do |i|
      ["memory_cell_#{i}", GatedLatch]
    end.to_h.merge(
        in_converter: DataToBits,
        out_converter: BitsToData
      )

    conns = { [:IN, :in_data] => [[:in_converter, :in_data]] }

    (1..WORD_SIZE).each do |i|
      conns[[:in_converter, i]] = [["memory_cell_#{i}", :data_bit]]
      conns[["memory_cell_#{i}", :q]] = [[:out_converter, i]]
    end

    conns[[:IN, :save]] = Array.new(WORD_SIZE) { |i| ["memory_cell_#{i+1}", :gate] }
    conns[[:out_converter, :out]] = [[:OUT, :out]]

    {
      components: comps,
      connections: conns
    }
  end
end
