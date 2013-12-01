module Rubicure
  class Girl
    attr_reader :current_state, :state_names, :transform_serif

    # @option config [String]        :human_name
    # @option config [String]        :precure_name
    # @option config [String]        :transform_serif
    # @option config [Array<String>] :extra_names
    def initialize(config={})
      @current_state = 0
      @transform_serif = config[:transform_serif]

      @state_names = [config[:human_name], config[:precure_name]]
      @state_names += config[:extra_names] if config.has_key?(:extra_names)
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
