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

    def respond_to_missing?(name, _include_private)
      unmarked_precure = Rubicure::Series.find(:unmarked)
      unmarked_precure.respond_to?(name)
    end

    # rubocop:disable Metrics/LineLength

    # get current precure series
    # @return [Rubicure::Series] current precure
    #
    # @raise [NotOnAirError] not onair!
    #
    # @example
    #   Precure.now
    #   #=> {:series_name=>"go_princess", :title=>"Go!プリンセスプリキュア", :started_date=>Sun, 01 Feb 2015, :girls=>["cure_flora", "cure_mermaid", "cure_twinkle", "cure_scarlet"]}
    def now
      current_time = Time.now
      each_with_series do |series|
        return series if series.on_air?(current_time)
      end
      raise NotOnAirError, "Not on air precure!"
    end
    # rubocop:enable Metrics/LineLength

    alias_method :current, :now

    # Get precure all stars
    #
    # @param [Time,Date,String,Symbol] arg Time, Date or date like String (ex. "2013-12-16")
    #
    # @return [Array<Rubicure::Girl>]
    #
    # @example precure all stars
    #   Precure.all_stars.count
    #   Precure.all_stars.map(&:precure_name)
    #   # returns current precure count and names
    #
    #   Precure.all_stars.include?(Cure.echo)
    #   #=> false
    #
    #   Precure.all_stars("2013-10-26").count
    #   #=> 33
    #
    #   Precure.all_stars(:dx).count
    #   #=> 14
    #
    #   Precure.all_stars(:dx2).count
    #   #=> 17
    #
    #   Precure.all_stars(:dx3).count
    #   #=> 21
    #
    #   Precure.all_stars(:new_stage).count
    #   #=> 29
    #   Precure.all_stars(:new_stage).include?(Cure.echo)
    #   #=> true
    #
    #   Precure.all_stars(:new_stage2).count
    #   #=> 32
    #
    #   Precure.all_stars(:new_stage3).count
    #   #=> 37
    #   Precure.all_stars(:new_stage3).include?(Cure.echo)
    #   #=> true
    #
    #   Precure.all_stars(:spring_carnival).count
    #   #=> 40
    #
    #   Precure.all_stars(:sing_together_miracle_magic).count
    #   #=> 44
    #   Precure.all_stars(:sing_together_miracle_magic).include?(Cure.echo)
    #   #=> true
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
          extra_girls = movie.extra_girls.map {|girl_name| Rubicure::Girl.find(girl_name.to_sym) }
        end
      end

      all_girls(date) - [Cure.echo] + extra_girls
    end

    # Get all precures
    #
    # @param [Time,Date] arg Time, Date or date like String (ex. "2013-12-16")
    #
    # @return [Array<Rubicure::Girl>] all precures
    #
    # @example
    #   Precure.all_girls.count
    #   Precure.all_girls.map(&:precure_name)
    #   # returns current precure count and names
    #
    #   Precure.all_girls("2013-10-26").count
    #   #=> 33
    #
    #   Precure.all_girls.include?(Cure.echo)
    #   #=> true
    def all_girls(arg = Time.current)
      date = to_date(arg)

      unless @all_girls
        @all_girls = []
        Rubicure::Girl.names.each do |girl_name|
          @all_girls << Rubicure::Girl.find(girl_name)
        end

        @all_girls.uniq!(&:human_name)
      end

      @all_girls.select {|girl| girl.created_date && girl.created_date <= date }
    end

    alias_method :all, :all_girls

    # Get precure dream stars
    #
    # @return [Array<Rubicure::Girl>] precure dream stars
    #
    # @example
    #   Precure.dream_stars.count
    #   #=> 12
    #
    #   Precure.dream_stars.map(&:precure_name)
    #   #=> ["キュアフローラ", "キュアマーメイド", "キュアトゥインクル", "キュアスカーレット", "キュアミラクル", "キュアマジカル", "キュアフェリーチェ", "キュアホイップ", "キュアカスタード", "キュアジェラート", "キュアマカロン", "キュアショコラ"]
    def dream_stars
      return @dream_stars if @dream_stars

      girls = Precure.go_princess.girls + Precure.maho_girls.girls + Precure.a_la_mode.girls

      dream_stars_date = Rubicure::Movie.find(:dream_stars).started_date
      @dream_stars = girls.select {|girl| girl.created_date && girl.created_date <= dream_stars_date }

      @dream_stars
    end

    # Get precure super stars
    #
    # @return [Array<Rubicure::Girl>] precure super stars
    #
    # @example
    #   Precure.super_stars.count
    #   #=> 12
    #
    #   Precure.super_stars.map(&:precure_name)
    #   #=> ["キュアミラクル", "キュアマジカル", "キュアフェリーチェ", "キュアホイップ", "キュアカスタード", "キュアジェラート", "キュアマカロン", "キュアショコラ", "キュアパルフェ", "キュアエール", "キュアアンジュ", "キュアエトワール"]
    def super_stars
      return @super_stars if @super_stars

      girls = Precure.maho_girls.girls + Precure.a_la_mode.girls + Precure.hugtto.girls

      super_stars_date = Rubicure::Movie.find(:super_stars).started_date
      @super_stars = girls.select {|girl| girl.created_date && girl.created_date <= super_stars_date }

      @super_stars
    end
    alias_method :superstars, :super_stars

    # rubocop:disable Metrics/LineLength

    # Get precure miracle universe
    #
    # @return [Array<Rubicure::Girl>] precure miracle universe
    #
    # @example
    #   Precure.miracle_universe.count
    #   #=> 15
    #
    #   Precure.miracle_universe.map(&:precure_name)
    #   #=> ["キュアホイップ", "キュアカスタード", "キュアジェラート", "キュアマカロン", "キュアショコラ", "キュアパルフェ", "キュアエール", "キュアアンジュ", "キュアエトワール", "キュアマシェリ", "キュアアムール", "キュアスター", "キュアミルキー", "キュアソレイユ", "キュアセレーネ"]
    def miracle_universe
      return @miracle_universe if @miracle_universe

      girls = Precure.a_la_mode.girls + Precure.hugtto.girls + Precure.star_twinkle.girls

      miracle_universe_date = Rubicure::Movie.find(:miracle_universe).started_date
      @miracle_universe = girls.select {|girl| girl.created_date && girl.created_date <= miracle_universe_date }

      @miracle_universe
    end

    # Get precure miracle leap
    #
    # @return [Array<Rubicure::Girl>] precure miracle leap
    #
    # @example
    #   Precure.miracle_leap.count
    #   #=> 13
    #
    #   Precure.miracle_leap.map(&:precure_name)
    #   #=> ["キュアエール", "キュアアンジュ", "キュアエトワール", "キュアマシェリ", "キュアアムール", "キュアスター", "キュアミルキー", "キュアソレイユ", "キュアセレーネ", "キュアグレース", "キュアフォンテーヌ", "キュアスパークル"]
    def miracle_leap
      return @miracle_leap if @miracle_leap

      girls = Precure.hugtto.girls + Precure.star_twinkle.girls + Precure.healingood.girls

      miracle_leap_date = Rubicure::Movie.find(:miracle_leap).started_date
      @miracle_leap = girls.select {|girl| girl.created_date && girl.created_date <= miracle_leap_date }
      @miracle_leap.reject! {|girl| girl == Cure.earth }

      @miracle_leap
    end

    # rubocop:enable Metrics/LineLength

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
