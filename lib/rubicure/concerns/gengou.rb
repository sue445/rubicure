module Rubicure
  module Concerns
    module Gengou
      refine Date do
        # Whether current date is Heisei
        def heisei?
          Date.new(1989, 1, 8) <= self && self <= Date.new(2019, 4, 30)
        end

        # Whether current date is Reiwa
        def reiwa?
          Date.new(2019, 5, 1) <= self
        end
      end
    end
  end
end
