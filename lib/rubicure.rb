require "rubicure/version"
require "rubicure/series"
require "rubicure/girl"
require "active_support/core_ext"

module Rubicure
  def method_missing(name, *args)
    series_name = case name
                    when :futari_wa_pretty_cure
                      :unmarked
                    when :futari_wa_pretty_cure_max_heart
                      :max_heart
                    when :futari_wa_pretty_cure_splash_star
                      :splash_star
                    when :yes_precure_five, :yes_precure5
                      :yes
                    when :yes_precure_five_gogo, :yes_precure5_gogo
                      :yes_gogo
                    when /_precure$/
                      name.to_s.gsub("_precure", "").to_sym
                    else
                      name
                  end

    if Rubicure::Series.valid?(series_name)
      Rubicure::Series.fetch(series_name)
    else
      super
    end
  end
end
