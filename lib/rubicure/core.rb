module Rubicure
  require "singleton"

  class Core
    include Singleton
    include Enumerable

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
      each_with_series do |series|
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

    # iterate with :unmarked, :max_heart, ...
    #
    # @yield series
    # @yieldparam series [Rubicure::Series]
    #
    # @return [Array<Symbol>] ex. :unmarked, :max_heart, ...
    def each_with_series
      Rubicure::Series.uniq_names.each do |series_name|
        series = Rubicure::Series.find(series_name)
        yield series
      end
    end

    alias :each :each_with_series
  end
end
