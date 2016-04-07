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

      @routes.push from: from, to: to, distance: distance
    end

    def neighbors city
      neighbors = []

      @routes.each do |route|
        neighbors.push route[:to] if route[:from] == city
      end

      return neighbors.uniq
    end

  end
end
