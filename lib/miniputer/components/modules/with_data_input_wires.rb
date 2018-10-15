module WithDataInputWires
  def data_input_wires
    @data_input_wires ||= (no_of_inputs / WORD_SIZE).times.map do |i|
      @input_wires[WORD_SIZE*i, WORD_SIZE]
    end
  end
end
