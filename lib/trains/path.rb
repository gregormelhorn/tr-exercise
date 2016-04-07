module Trains
  class Path
    attr_reader :routes

    def initialize routes=[]
      @routes = routes.dup
    end

    def distance
      @routes.inject(0){|sum,e| sum + e.distance}
    end

    def from
      @routes.first ? @routes.first.from : nil
    end

    def to
      @routes.last ? @routes.last.to : nil
    end

    def <<(route)
      raise ArgumentError.new("Can only add route from current end point #{to}, tried #{route.from}") if to and to != route.from
      @routes << route
    end

    def to_s
      "Path(distance: #{distance}, path: #{@routes.first ? @routes.first.from : 'empty'} -> #{@routes.map(&:to).join(' -> ')})"
    end

    def length
      @routes.length
    end
  end
end
