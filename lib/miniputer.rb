require 'require_all'

require_all 'lib/miniputer/helpers'

require_all 'lib/miniputer/wires'
require_relative 'miniputer/components/component_base'
require_relative 'miniputer/components/atomic_component'
require_relative 'miniputer/components/composite_component'
require_all 'lib/miniputer/components'
require_all 'lib/miniputer/physics'
require_relative 'miniputer/constants'

require_relative 'miniputer/machines/machine'
require_relative 'miniputer/machines/adder_box'
require_relative 'miniputer/machines/friendly_adder_box'
require_relative 'miniputer/machines/friendly_add_sub_box'
require_relative 'miniputer/machines/add_sub_box'
require_relative 'miniputer/machines/clock_box'

require 'byebug'
