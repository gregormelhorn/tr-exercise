module Trains
  class Network < Array
    class RouteNotFound < StandardError; end

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

    def neighbor_routes city
      neighbors = []

      @routes.each do |route|
        neighbors.push route if route.from == city
      end

      neighbors
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

    def find_paths from, to, path = nil, &block
      path ||= Path.new
      paths = []
      neighbor_routes(from).each do |neighbor_route|
        new_path = Path.new(path.routes)
        new_path << neighbor_route

        # check if this subpath is valid
        if yield(new_path)

          # if we did reach the target city
          if to == neighbor_route.to
            paths << new_path
          end
          paths = paths + find_paths(neighbor_route.to, to, new_path, &block)
        end
      end

      paths
    end


    def find_max_stops(from, to, stops)
      check_cities!(from, to)

      find_paths(from, to){|path| path.length <= stops}
    end

    def find_exact_stops(from, to, stops)
      find_max_stops(from, to, stops).select{|path| path.length == stops}
    end

    def find_max_distance(from, to, distance)
      check_cities!(from, to)

      find_paths(from, to){|path| path.distance <= distance}
    end

protected

    def check_cities! *cities
      cities.each do |city|
        raise RouteNotFound("could not find city #{city}, so no route was found") unless include? city
      end
    end

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
