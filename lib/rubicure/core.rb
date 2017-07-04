module Rubicure
  require "singleton"

  # generic methods
  class Core
    include Singleton
    include Enumerable
    include Rubicure::Concerns::Util

    Rubicure::Series.names.each do |series_name|
      define_method series_name do
        Rubicure::Series.find(series_name)
      end
    end

    def method_missing(name, *args)
      unmarked_precure = Rubicure::Series.find(:unmarked)

      if unmarked_precure.respond_to?(name)
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
      raise NotOnAirError, "Not on air precure!"
    end

    alias_method :current, :now

    # @param [Time,Date,String,Symbol] arg Time, Date or date like String (ex. "2013-12-16")
    # @return [Array<Rubicure::Girl>]
    def all_stars(arg = Time.current)
      extra_girls = []

      # args is Time or Date
      date = to_date(arg)

      if date
        last_all_stars_date = Rubicure::Movie.find(:stmm).started_date
        if date > last_all_stars_date
          date = last_all_stars_date
        end
      else
        # args is movie name
        movie = Rubicure::Movie.find(arg.to_sym)
        date = movie.started_date

        if movie.has_key?(:extra_girls)
          extra_girls = movie.extra_girls.map { |girl_name| Rubicure::Girl.find(girl_name.to_sym) }
        end
      end

      all_girls(date) - [Cure.echo] + extra_girls
    end

    # @param [Time,Date] arg Time, Date or date like String (ex. "2013-12-16")
    # @return [Array<Rubicure::Girl>]
    def all_girls(arg = Time.current)
      date = to_date(arg)

      unless @all_girls
        @all_girls = []
        Rubicure::Girl.names.each do |girl_name|
          @all_girls << Rubicure::Girl.find(girl_name)
        end

        @all_girls.uniq!(&:human_name)
      end

      @all_girls.select { |girl| girl.created_date && girl.created_date <= date }
    end

    alias_method :all, :all_girls

    def dream_stars
      return @dream_stars if @dream_stars
      girls = Precure.go_princess.girls + Precure.maho_girls.girls + Precure.a_la_mode.girls

      dream_stars_date = Rubicure::Movie.find(:dream_stars).started_date
      @dream_stars = girls.select { |girl| girl.created_date && girl.created_date <= dream_stars_date }

      @dream_stars
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
