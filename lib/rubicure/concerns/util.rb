module Rubicure
  module Concerns
    # utility methods
    module Util
      # @param arg [Date,Time,String]
      #
      # @return [Date] arg is String, Date or Time
      # @return [nil] arg is other
      def to_date(arg)
        case arg
        when Date
          arg
        when Time
          arg.to_date
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

      module_function

      # @param yaml_file [String]
      # @return [Hash]
      def load_yaml_file(yaml_file)
        YAML.safe_load(File.read(yaml_file), permitted_classes: [Date], aliases: true)
      end
    end
  end
end
