module Model
  class TeamsSetup
    HUMAN_TYPE = 1
    COMPUTER_TYPE = 2

    attr_reader :team_types

    def initialize(args)
      @team_klass = args[:team_klass]
      @piece_klass = args[:piece_klass]
      @move_klass = args[:move_klass]
      @move_strategy_klass = args[:move_strategy_klass]
      @team_types = { "Player": HUMAN_TYPE, "Computer": COMPUTER_TYPE }
    end

    def create_teams(teams_args)
      teams_args.map { |args| create_team(args) }
    end

    private

    def create_team(args)
      name = args[:name]
      piece = @piece_klass.new(name, @move_klass)
      move_strategy = args[:type] == COMPUTER_TYPE ? @move_strategy.new : nil
      @team_klass.new(name:          name,
                      move_strategy: move_strategy,
                      pieces:        [piece])
    end
  end
end