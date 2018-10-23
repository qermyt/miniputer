class BlueprintTranslater
  class << self
    def class_to_yml(comp_class)
      bp = comp_class.blueprint
      yml = {
        'name' => nil,
        'in' => {},
        'components' => {},
        'out' => {}
      }

      yml['name'] = comp_class.to_s

      bp[:components].each do |label, klass|
        yml['components'][label.to_s] = { 'class' => klass.to_s }
      end

      bp[:connections].each do |source, sinks|
        if source.first == :IN
          wire_label = source.last.to_s
          wire_type = Wire.wire_type(wire_label)
          yml['in'][source.last.to_s] = wire_type.to_s
        end

        sinks.each do |out_comp, out_label|
          if out_comp == :OUT
            yml['out'][out_label.to_s] = source.join('.').downcase
          else
            yml['components'][out_comp.to_s][out_label.to_s] = source.join('.').downcase
          end
        end
      end

      return yml
    end

    def yml_to_blueprint(yml_hash)
      blueprint = {
        components: {},
        connections: {}
      }

      yml_hash['components'].each do |comp_name, comp_config|
        add_component_to_blueprint(
          blueprint,
          comp_name,
          comp_config['class']
        )
      end

      yml_hash['components'].each do |sink_comp, comp_config|
        comp_config.each do |sink_label, source_str|
          next if sink_label == 'class'

          add_sink_to_blueprint(
            blueprint,
            source_str,
            [sink_comp.to_sym, sink_label.to_sym]
          )
        end
      end

      yml_hash['out'].each do |out_label, source_str|
        add_sink_to_blueprint(
          blueprint,
          source_str,
          [:OUT, out_label.to_sym]
        )
      end

      return blueprint
    end

    private

    def add_component_to_blueprint(blueprint, comp_name, comp_class)
        blueprint[:components][comp_name.to_sym] = const_get(comp_class)
    end

    def add_sink_to_blueprint(blueprint, source_str, sink)
      source = source_str.split('.')
      source.first.tap { |s| s.upcase! if %w(in out).include?(s) }
      source.map!(&:to_sym)
      blueprint[:connections][source] ||= []
      blueprint[:connections][source] << sink
    end
  end
end
