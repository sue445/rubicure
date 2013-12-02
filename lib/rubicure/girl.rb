module Rubicure
  class Girl
    attr_reader :current_state, :state_names, :transform_serif

    # @param [String]        human_name
    # @param [String]        precure_name
    # @param [String]        transform_serif
    # @param [Array<String>] extra_names
    def initialize(human_name: nil, precure_name: nil, transform_serif: nil, extra_names: [])
      @current_state = 0
      @transform_serif = transform_serif

      @state_names = [human_name, precure_name]
      @state_names += extra_names unless extra_names.empty?
    end

    # @return [String] name of current form
    def name
      @state_names[@current_state]
    end

    # human -> precure ( -> extra forms ) -> human ...
    def transform
      @current_state += 1
      @current_state = 0 unless @current_state < @state_names.length
      puts @transform_serif if @current_state == 1
    end

    def humanize
      @current_state = 0
    end
  end
end
