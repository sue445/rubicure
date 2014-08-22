module Rubicure
  module Concerns
    # utility methods
    module Util
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
end
