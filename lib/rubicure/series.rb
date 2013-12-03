module Rubicure
  class Series < Hash
    include Hashie::Extensions::MethodAccess

    def on_air?(date)
      if respond_to?(:started_date)
        if respond_to?(:ended_date)
          # ended title
          return (started_date .. ended_date).cover?(date)
        else
          # on air title
          return started_date <= date
        end
      end

      false
    end

    # @return [Array<Rubicure::Girl>]
    def girls
      unless @girls
        @girls = []
        if has_key?(:girls)
          fetch(:girls).each do |info|
            girl_hash = info.symbolize_keys
            girl_hash[:transform_message] = "#{fetch(:common_transform_message,"")}#{girl_hash[:transform_message]}"
            @girls << Rubicure::Girl.new(girl_hash)
          end
        end
      end

      @girls
    end
  end
end
