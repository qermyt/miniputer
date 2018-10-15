module Physics
  class ElectricFlow
    attr_reader :wireflow

    def initialize
      @wireflow = []
    end

    def stable?
      @wireflow.empty?
    end

    def mark_as_flowing(wire)
      @wireflow << wire
    end

    def flow_next_wire
      wire = @wireflow.shift
      wire.flow
    end

    def flow_all
      @wireflow.size.times do
        flow_next_wire
      end
    end

    def resolve_next_wire_groups(n)
      n.times do
        resolve_next_wire_group
      end
    end

    def flow_until_stable
      until stable? do
        flow_all
      end
    end
  end
end
