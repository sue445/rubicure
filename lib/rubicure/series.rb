module Rubicure
  class Series < Hash
    include Hashie::Extensions::MethodAccess

    # @param [Time,Date,String] arg Time, Date or date like String (ex. "2013-12-16")
    def on_air?(arg)
      date = to_date(arg)
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

            # FIXME
            girl_hash[:transform_message] = case girl_hash[:precure_name]
              when "シャイニールミナス", "ミルキィローズ"
                girl_hash[:transform_message]
              else
                "#{fetch(:before_transform_message,"")}#{girl_hash[:transform_message]}#{fetch(:after_transform_message,"")}"
            end
            @girls << Rubicure::Girl.new(girl_hash)
          end
        end
      end

      @girls
    end

    private
      # @param arg
      # @return [Date] arg is String or Date
      # @return [Time] arg is Time
      # @return [nil] arg is other
      def to_date(arg)
        case arg
          when Date, Time
            arg
          when String
            Date.parse(arg)
          else
            nil
        end
      end
  end
end
