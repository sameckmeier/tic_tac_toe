module Model
  class BoardSetup
    HUMAN_TYPE = 1
    COMPUTER_TYPE = 2

    attr_reader :team_types

    def initialize(args)
      @args = args || {}
      @team_types = { "Player": HUMAN_TYPE, "Computer": COMPUTER_TYPE }
    end

    def create
      dimensions = @args[:dimensions]
      tiles = create_tiles(dimensions)
      teams = create_teams

      Model::Board.new(tile_collection: Model::TileCollection.new(tiles, dimensions),
                       team_collection: Model::TeamCollection.new(teams),
                       game_state:      Model::GameState.new)
    end

    def update(args)
      @args.merge!(args)
    end

    private

    def create_tiles(dimensions)
      cnt = dimensions ** 2
      (1..cnt).map { |i| Model::Tile.new }
    end

    def create_teams
      @args[:teams].map { |args| create_team(args) }
    end

    def create_team(args)
      name = args[:name]
      piece = Model::Piece.new(name, Model::MoveFactory.new)
      move_strategy = args[:type] == COMPUTER_TYPE ? Model::MoveStrategy.new : nil
      Model::Team.new(name:          name,
                      move_strategy: move_strategy,
                      pieces:        [piece])
    end
  end
end
