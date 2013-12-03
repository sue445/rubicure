module Rubicure
  class Girl
    attr_reader :human_name, :precure_name, :current_state, :state_names, :transform_message

    # @param [String]        human_name
    # @param [String]        precure_name
    # @param [String]        transform_message
    # @param [Array<String>] extra_names
    def initialize(human_name: nil, precure_name: nil, transform_message: nil, extra_names: [])
      @human_name = human_name
      @precure_name = precure_name
      @current_state = 0
      @transform_message = transform_message

      @state_names = [human_name, precure_name]
      @state_names += extra_names if extra_names && !extra_names.empty?
    end

    # @return [String] name of current form
    def name
      @state_names[@current_state]
    end

    # human -> precure ( -> extra forms ) -> human ...
    def transform
      @current_state += 1
      @current_state = 0 unless @current_state < @state_names.length

      puts @transform_message  if @current_state == 1

      self
    end

    def humanize
      @current_state = 0
    end
  end
end
