module Rubicure
  require "singleton"

  # generic methods
  class Core
    include Singleton
    include Enumerable
    include Rubicure::Concerns::Util

    def method_missing(name, *args)
      unmarked_precure = Rubicure::Series.find(:unmarked)

      if Rubicure::Series.valid?(name)
        Rubicure::Series.find(name)
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

    alias_method :current, :now

    # @param [Time,Date,String,Symbol] arg Time, Date or date like String (ex. "2013-12-16")
    # @return [Array<Rubicure::Girl>]
    def all_stars(arg = Time.current)
      unless @all_stars
        @all_stars = []
        Rubicure::Girl.names.each do |girl_name|
          @all_stars << Rubicure::Girl.find(girl_name)
        end

        @all_stars.uniq! { |girl| girl.human_name }
      end

      begin
        movie = Rubicure::Movie.find(arg.to_sym)
        date = movie.started_date
      rescue
        # args is Time or Date
        date = to_date(arg)
      end

      @all_stars.select { |girl| girl.created_date && girl.created_date <= date }
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

    alias_method :each, :each_with_series
  end
end
