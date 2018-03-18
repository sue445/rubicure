module Rubicure
  module Concerns
    # utility methods
    module Util
      # @param arg [Date,Time,String]
      #
      # @return [Date] arg is String or Date
      # @return [Time] arg is Time
      # @return [nil] arg is other
      def to_date(arg)
        case arg
        when Date, Time
          arg
        when String
          begin
            Date.parse(arg)
          rescue
            nil
          end
        else
          nil
        end
      end
    end
  end
end
