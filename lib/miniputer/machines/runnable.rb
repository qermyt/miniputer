require 'curses'
require_relative 'helpers/state_printer'

module Runnable
  def irun
    Curses.init_screen

    @prev_actions ||= Array.new(5)

    @ticking == false
    @tick_count = 1

    loop do
      @action = state_printer.print(skip_action: skip?)
      respond_to_action
      break if done?

      update_action_history
      PHYSICS.run_one_clock_tick
    end
  ensure
    Curses.close_screen
  end

  def done?
    @done
  end

  def skip?
    !PHYSICS.equilibrium? || @skip
  end

  def respond_to_action
    case @action
    when 'quit' then @done = true
    when /^set (.+)/ then get_switch($1).set_value(HIGH)
    when /^reset (.+)/ then get_switch($1).set_value(LOW)
    when 'w' then @ticking = true
    end
  end

  def get_switch(sw)
    switch_label, sub = sw.split('.')
    switch = switches[switch_label.to_sym]
    sub ? switch[sub.to_i] : switch
  end

  def tick
    PHYSICS.tick
  end

  def update_action_history
    @prev_actions.shift
    @prev_actions << (@tick_count += 1)
  end

  def print_state
    @action = state_printer.print
  end

  def state_printer
    @state_printer ||= StatePrinter.new(display_switches, bulbs)
  end
end
