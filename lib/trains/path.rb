module Trains
  class Path < Array
    def distance
      inject(0){|sum,e| sum + e.distance}
    end
  end
end
