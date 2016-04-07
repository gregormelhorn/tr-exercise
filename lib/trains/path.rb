module Trains
  class Path < Array
    def distance
      inject(0){|sum,e| sum + e.distance}
    end

    def from
      first ? first.from : nil
    end

    def to
      last ? last.to : nil
    end

    def <<(route)
      raise ArgumentError.new("Can only add route from current end point #{to}, tried #{route.from}") if to and to != route.from
      super
    end
  end
end
