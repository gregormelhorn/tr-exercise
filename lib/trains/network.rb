module Trains
  class Network < Array
    attr_reader :routes

    def initialize data
      @routes = []
      data.scan(/([A-Z])([A-Z])(\d+)/) do |source, target, distance|
        add_route source, target, distance.to_i
      end
    end

    def add_route from, to, distance
      push from unless self.include? from
      push to unless self.include? to

      @routes.push Route.new(from, to, distance)
    end

    def neighbors city
      neighbors = []

      @routes.each do |route|
        neighbors.push route.to if route.from == city
      end

      return neighbors.uniq
    end

    def find_route(from, to)
      @routes.find{|route| route.from == from and route.to == to}
    end

    def total_distance *cities
      distance = 0

      while (from = cities.shift) and cities.length > 0
        to = cities.first
        route = find_route from, to
        return Float::INFINITY unless route
        distance = distance + route.distance
      end

      distance
    end
  end
end
