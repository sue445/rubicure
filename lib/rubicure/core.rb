module Rubicure
  require "singleton"

  class Core
    include Singleton

    def method_missing(name, *args)
      unmarked_precure = Rubicure::Series::find(:unmarked)

      if Rubicure::Series::valid?(name)
        Rubicure::Series::find(name)
      elsif unmarked_precure.respond_to?(name)
        unmarked_precure.send(name, *args)
      else
        super
      end
    end

    # @return [Series] current precure
    # @raise not onair!
    def now
      current_time = Time.now
      Rubicure::Series.names.each do |name|
        series = Rubicure::Series.find(name)
        return series if series.on_air?(current_time)
      end
      raise "Not on air precure!"
    end

    alias :current :now

    # @return [Array<Rubicure::Girl>]
    def all_stars
      unless @all_stars
        @all_stars = []
        Rubicure::Girl.names.each do |girl_name|
          @all_stars << Rubicure::Girl.find(girl_name)
        end

        @all_stars.uniq!{|girl| girl.precure_name }
      end

      @all_stars
    end
  end
end
