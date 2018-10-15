class ThreeDpRegister < CompositeComponent
  private

  def self.blueprint
    {
      components: {
        dp1: OneDpRegister,
        dp2: OneDpRegister,
        dp3: OneDpRegister,

        n_incr: NotGate,

        dp1_carry_latch: GatedLatch,
        dp2_carry_latch: GatedLatch,
        dp1_carry: AndGate,
        dp2_carry: AndGate,

        in_units: DataToBits,
        in_tens: DataToBits,
        in_hundreds: DataToBits,

        out_units: BitsToDecimal,
        out_tens: BitsToDecimal,
        out_hundreds: BitsToDecimal

      },
      connections: {
        [:IN, :set] => [
          [:dp1, :set],
          [:dp2, :set],
          [:dp3, :set]
        ],
        [:IN, :reset] => [
          [:dp1, :reset],
          [:dp2, :reset],
          [:dp3, :reset]
        ],
        [:IN, :incr] => [
          [:dp1, :incr],
          [:dp1_carry, :in1],
          [:n_incr, :in1],
        ],

        [:n_incr, :out] => [
          [:dp1_carry_latch, :gate],
          [:dp2_carry_latch, :gate]
        ],
        [:dp1_carry_latch, :q] => [[:dp1_carry, :in2]],
        [:dp2_carry_latch, :q] => [[:dp2_carry, :in2]],


        [:dp1_carry, :out] => [[:dp2, :incr], [:dp2_carry, :in1]],
        [:dp2_carry, :out] => [[:dp3, :incr]],

        [:IN, :decimal_units] => [[:in_units, :in1]],

        [:in_units, 1] => [[:dp1, :in_d0]],
        [:in_units, 2] => [[:dp1, :in_d1]],
        [:in_units, 3] => [[:dp1, :in_d2]],
        [:in_units, 4] => [[:dp1, :in_d3]],
        [:in_units, 5] => [[:dp1, :in_d4]],
        [:in_units, 6] => [[:dp1, :in_d5]],
        [:in_units, 7] => [[:dp1, :in_d6]],
        [:in_units, 8] => [[:dp1, :in_d7]],
        [:in_units, 9] => [[:dp1, :in_d8]],
        [:in_units, 10] => [[:dp1, :in_d9]],


        [:IN, :decimal_tens] => [[:in_tens, :in1]],

        [:in_tens, 1] => [[:dp2, :in_d0]],
        [:in_tens, 2] => [[:dp2, :in_d1]],
        [:in_tens, 3] => [[:dp2, :in_d2]],
        [:in_tens, 4] => [[:dp2, :in_d3]],
        [:in_tens, 5] => [[:dp2, :in_d4]],
        [:in_tens, 6] => [[:dp2, :in_d5]],
        [:in_tens, 7] => [[:dp2, :in_d6]],
        [:in_tens, 8] => [[:dp2, :in_d7]],
        [:in_tens, 9] => [[:dp2, :in_d8]],
        [:in_tens, 10] => [[:dp2, :in_d9]],


        [:IN, :decimal_hundreds] => [[:in_hundreds, :in1]],

        [:in_hundreds, 1] => [[:dp3, :in_d0]],
        [:in_hundreds, 2] => [[:dp3, :in_d1]],
        [:in_hundreds, 3] => [[:dp3, :in_d2]],
        [:in_hundreds, 4] => [[:dp3, :in_d3]],
        [:in_hundreds, 5] => [[:dp3, :in_d4]],
        [:in_hundreds, 6] => [[:dp3, :in_d5]],
        [:in_hundreds, 7] => [[:dp3, :in_d6]],
        [:in_hundreds, 8] => [[:dp3, :in_d7]],
        [:in_hundreds, 9] => [[:dp3, :in_d8]],
        [:in_hundreds, 10] => [[:dp3, :in_d9]],



        [:dp1, :d0] => [[:out_units, 1]],
        [:dp1, :d1] => [[:out_units, 2]],
        [:dp1, :d2] => [[:out_units, 3]],
        [:dp1, :d3] => [[:out_units, 4]],
        [:dp1, :d4] => [[:out_units, 5]],
        [:dp1, :d5] => [[:out_units, 6]],
        [:dp1, :d6] => [[:out_units, 7]],
        [:dp1, :d7] => [[:out_units, 8]],
        [:dp1, :d8] => [[:out_units, 9]],
        [:dp1, :d9] => [
          [:out_units, 10],
          [:dp1_carry_latch, :data_bit]
        ],

        [:out_units, :out] => [[:OUT, :units]],


        [:dp2, :d0] => [[:out_tens, 1]],
        [:dp2, :d1] => [[:out_tens, 2]],
        [:dp2, :d2] => [[:out_tens, 3]],
        [:dp2, :d3] => [[:out_tens, 4]],
        [:dp2, :d4] => [[:out_tens, 5]],
        [:dp2, :d5] => [[:out_tens, 6]],
        [:dp2, :d6] => [[:out_tens, 7]],
        [:dp2, :d7] => [[:out_tens, 8]],
        [:dp2, :d8] => [[:out_tens, 9]],
        [:dp2, :d9] => [
          [:out_tens, 10],
          [:dp2_carry_latch, :data_bit]
        ],

        [:out_tens, :out] => [[:OUT, :tens]],


        [:dp3, :d0] => [[:out_hundreds, 1]],
        [:dp3, :d1] => [[:out_hundreds, 2]],
        [:dp3, :d2] => [[:out_hundreds, 3]],
        [:dp3, :d3] => [[:out_hundreds, 4]],
        [:dp3, :d4] => [[:out_hundreds, 5]],
        [:dp3, :d5] => [[:out_hundreds, 6]],
        [:dp3, :d6] => [[:out_hundreds, 7]],
        [:dp3, :d7] => [[:out_hundreds, 8]],
        [:dp3, :d8] => [[:out_hundreds, 9]],
        [:dp3, :d9] => [[:out_hundreds, 10]],

        [:out_hundreds, :out] => [[:OUT, :hundreds]]
      }
    }

  end
end
