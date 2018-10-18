require 'curses'

class StatePrinter
  include Curses

  def initialize(switches, bulbs)
    Curses.crmode
    Curses.noecho
    Curses.start_color

    Curses.init_pair(1, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)
    Curses.init_pair(2, Curses::COLOR_GREEN, Curses::COLOR_BLACK)

    @ind = 0
    @switches = switches
    @switch_labels = display_switches.keys
    @bulbs = bulbs
    @prev_actions = Array.new(5)

    @selected_switch_row = 0
    @selected_switch_col = 0

    chassis.keypad = true

    display_action_prompt
    display_bulbs
    display_switches
    display_action_history
    highlight_selected_switch
  end

  def print(skip_action: false)
    update_action_history
    display_bulbs
    display_switches
    display_action_history
    highlight_selected_switch

    action_box.refresh
    chassis.refresh

    return skip_action ? nil : get_action
  end

  def display_action_prompt
    action_box.setpos(2, 3)
    action_box.attrset(Curses.color_pair(2))
    action_box.addstr("What do?")
    action_box.setpos(4, 3)
    action_box.addstr('.' * 10)
  end

  def display_action_history
    @prev_actions.each_with_index do |action, i|
      action_box.setpos(5 + i, 3)
      action_box.clrtoeol
      action_box.addstr(action.to_i.to_s)
    end
  end

  def get_action
    loop do
      @action = chassis.getch #action_box.getstr
      case @action
      when Curses::KEY_RIGHT then move_selection_right
      when Curses::KEY_LEFT  then move_selection_left
      when Curses::KEY_UP    then move_selection_up
      when Curses::KEY_DOWN  then move_selection_down
      when ' ' then
        selected_switch.flip if selected_switch
        return nil
      when 't' then return 't'
      when 27, 'q' then return 'quit'
      end
      break if @action = Curses::KEY_ENTER
    end
  end

  def move_selection_right
    unless @selected_switch_col >=
           @switches[selected_switch_label].size - 1
      @selected_switch_col += 1
    end
  end

  def move_selection_left
    @selected_switch_col -= 1 unless @selected_switch_col <= 0
  end

  def move_selection_up
    @selected_switch_row -= 1 unless @selected_switch_row <= 0
  end

  def move_selection_down
    unless @selected_switch_row >= @switches.keys.size - 1
      @selected_switch_row += 1
    end
  end


  def update_action_history
    @tick_count ||= 0

    @prev_actions.pop
    @prev_actions.unshift(@tick_count += 1)  #@action)
  end

  def clean
    chassis.close
    action_box.close
  end

  private

  def selected_switch_label
    @switch_labels[@selected_switch_row]
  end

  def selected_switch
    return nil if @switches.empty?
    @switches[selected_switch_label][@selected_switch_col]
  end

  def switch_pos(i, j)
    row, col = switches_pos
    [row + 4*i + 2, col + 3*j + 1]
  end

  def display_flow_info
    nil

  end

  def chassis
    @chassis ||= Curses::Window.new(
      Curses.lines - 4,
      Curses.cols - 40,
      2,
      2
    ).tap do |win|
      win.box('|', '-')
    end
  end

  def action_box
    @action_box ||= Curses::Window.new(
      20,
      40 - 6,
      2,
      Curses.cols - 40 + 4
    ).tap do |win|
      win.box(':', '.')
    end
  end

  def display_bulbs
    row, col = bulbs_pos
    @bulbs.each_with_index do |(row_label, bulb_row), i|
      chassis.setpos(row + 4*i, col)
      chassis.attrset(Curses.color_pair(0))
      chassis.addstr(row_label.to_s)
      chassis.setpos(row + 4*i + 2, col)
      bulb_row.each do |bulb|
        display_bulb(bulb)
      end
    end
  end

  def display_bulb(bulb)
    if bulb.value
      chassis.attrset(Curses.color_pair(1) | Curses::A_BOLD)
      ch = '>O< '
    else
      chassis.attrset(Curses.color_pair(0))
      ch = ' O  '
    end
    chassis.addstr(ch)
  end

  def display_switches
    chassis.attrset(Curses.color_pair(0))

    row, col = switches_pos
    @switches.each_with_index do |(label, switch_row), i|
      chassis.setpos(row + 4*i, col)
      chassis.addstr(label.to_s)
      chassis.setpos(row + 4*i + 2, col)
      switch_row.each do |switch|
        display_switch(switch)
      end
    end
  end

  def display_switch(switch)
    ch = switch.value ? ' / ' : ' | '
    chassis.addstr(ch)
  end

  def highlight_selected_switch
    chassis.setpos(*switch_pos(@selected_switch_row, @selected_switch_col))
  end

  def bulbs_pos
    [2, 5]
  end

  def switches_pos
    [2, 50]
  end

  def print_switch(label, wire)
    puts "#{label}: #{wire.value ? 'ON' : 'OFF'}"
  end

  def print_bulbs(bulb_row)
    puts bulb_row.map { |b| b.value ? '!' : '.' }.join
  end
end
