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
      path = Path.new

      while (from = cities.shift) and cities.length > 0
        to = cities.first
        route = find_route from, to
        raise RouteNotFound.new("could not find route between #{from} and #{to}") unless route
        path << route
      end
      return path.distance
    end

    def find_paths from, to, path = nil, &block
      path ||= Path.new
      paths = []
      neighbor_routes(from).each do |neighbor_route|
        new_path = Path.new(path.routes)
        new_path << neighbor_route

        # check if this subpath is valid
        if yield(new_path)

          # if we did reach the target city, add path to solutions
          if to == neighbor_route.to
            paths << new_path
          end
          # get paths from all routes based on this one as well
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

    def shortest_path from, to
      distances = Hash.new Float::INFINITY
      cities = clone

      if from == to
        neighbor_routes(from).each { |neighbor| distances[neighbor.to] = neighbor.distance }
      else
        distances[from] = 0
      end

      until cities.empty?
        closest = cities.min_by { |city| distances[city] }
        cities.delete closest

        break if distances[closest] == Float::INFINITY

        neighbor_routes(closest).each do |neighbor_route|
          candidate_distance = distances[closest] + neighbor_route.distance
          distances[neighbor_route.to] = candidate_distance if candidate_distance < distances[neighbor_route.to]
        end
      end
      return distances[to]
    end

protected

    def check_cities! *cities
      cities.each do |city|
        raise RouteNotFound("could not find city #{city}, so no route was found") unless include? city
      end
    end
  end
end
