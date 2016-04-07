module Trains
  class Network < Array
    class RouteNotFound < StandardError;end

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

    def distance *cities
      begin
        return get_path(*cities).distance
      rescue RouteNotFound
        return Float::INFINITY
      end
    end

protected

    def get_path *cities
      @path = Path.new

      while (from = cities.shift) and cities.length > 0
        to = cities.first
        route = find_route from, to
        raise RouteNotFound.new("could not find route between #{from} and #{to}") unless route
        @path << route
      end

      @path
    end

  end
end
