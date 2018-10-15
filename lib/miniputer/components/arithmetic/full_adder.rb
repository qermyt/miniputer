class FullAdder < CompositeComponent
  def no_of_inputs
    2*WORD_SIZE
  end

  def no_of_outputs
    WORD_SIZE
  end

  private

  def self.in1_source(bit_index)
    [:in1_converter, bit_index]
  end

  def self.in2_source(bit_index)
    [:in2_converter, bit_index]
  end

  def self.out_sink(bit_index)
    [:out_converter, bit_index]
  end

  def self.adder(level, rank)
    "adder-#{level}-#{rank}"
  end

  def self.adder_sink(level, rank, in_label)
    [adder(level, rank), in_label]
  end

  def self.adder_source(level, rank, out_label)
    [adder(level, rank), out_label]
  end

  def self.blueprint
    comps = {}
    (1..WORD_SIZE).each do |level|
      (level..WORD_SIZE).each do |i|
        comps[adder(level, i)] = BitAdder
      end
    end
    comps[:in1_converter] = DataToBits
    comps[:in2_converter] = DataToBits
    comps[:out_converter] = BitsToData

    conns = {
      [:IN, :in_data1] => [[:in1_converter, :in_data]],
      [:IN, :in_data2] => [[:in2_converter, :in_data]],
      [:out_converter, :out] => [[:OUT, :data]]
    }
    (1..WORD_SIZE).each do |level|
      (level..WORD_SIZE).each do |rank|
        if level == 1
          conns[in1_source(rank)] = [adder_sink(1, rank, :bit1)]
          conns[in2_source(rank)] = [adder_sink(1, rank, :bit2)]
        else
          conns[adder_source(level-1, rank, :sum)] =
            [adder_sink(level, rank, :bit1)]
          conns[adder_source(level-1, rank-1, :carry)] =
            [adder_sink(level, rank, :bit2)]
        end

        conns[adder_source(level, rank, :sum)] = [out_sink(rank)]
      end
    end

    {
      components: comps,
      connections: conns
    }
  end

  #
  #                                                OUT
  #                                              ^^^^^^^
  #                                              ||...||
  #                                              ||...||
  #                                       o   .--`|...||
  #                                       |   |   |...||
  #                                       c   s   |...||
  #                                      .-----.  |...||
  #   LEVEL N                            | ADD |  |...||
  #                                      '-----'  |...||
  #                                        | |    |...||
  #                                        : :    ::::::
  #      :                                           :::
  #      :                                           |||
  #      :                 :   :    :   :    :   .---`||
  #                        |   |    |   |    |   |    ||
  #                        c   s    c   s    c   s    ||
  #                       .-----.  .-----.  .-----.   ||
  #   LEVEL 2             | ADD |  | ADD |  | ADD |   ||
  #                       '-----'  '-----'  '-----'   ||
  #                         | |      | |      | |     ||
  #                         : |   .--` |   .--` |   .-`|
  #                           |   |    |   |    |   |  |
  #                           c   s    c   s    c   s  |
  #                          .-----.  .-----.  .-----. |
  #   LEVEL 1                | ADD |  | ADD |  | ADD | |
  #                          '-----'  '-----'  '-----' |
  #                      :     | |      | |      | |   |
  #               o   .--`     : |   .--` |   .--` |   |
  #               |   |          |   |    |   |    |   |
  #               c   s          c   s    c   s    c   s
  #              .-----.        .-----.  .-----.  .-----.
  #   LEVEL 0    | ADD |   ...  | ADD |  | ADD |  | ADD |
  #              '-----'        '-----'  '-----'  '-----'
  #                | |            | |      | |      | |
  #   .------------` |            | |      | |      | |
  #   |              |            | |      | |      | |
  #   :              :            | |      | |      | |
  #   :              :            | |      | |      | |
  #   |   .----------|------------` |      | |      | |
  #   |...|          |   .----------`      | |      | |
  #   |...|.---------|...|-----------------` |      | |
  #   |...||         |...|.------------------`      | |
  #   |...||.--------|...||-------------------------` |
  #   |...|||        |...||.--------------------------`
  #   |...|||        |...||||
  #   ^^^^^^^        ^^^^^^^^
  #    IN-1           IN-2


end
