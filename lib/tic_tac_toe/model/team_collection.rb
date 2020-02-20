module Model
  class TeamCollection
    def initialize(teams)
      @teams = teams
      @head = teams[0]
      @rest = teams[1..-1]
    end

    def current
      @head
    end

    def next
      @rest << @head

      @head = @rest.shift
    end

    def clone
      teams = [@head].concat(@rest)

      self.class.new(teams)
    end
  end
end
