module Model
  class BoardSetup
    attr_accessor :teams

    def initialize(args)
      @board_klass = args[:board_klass]
      @tile_collection_klass = args[:tile_collection_klass]
      @team_collection_klass = args[:team_collection_klass]
      @game_state = args[:game_state]
      @tile_klass = args[:tile_klass]
      @dimensions = args[:dimensions]
      @teams = []
    end

    def create_board
      tiles = create_tiles

      @board_klass.new(tile_collection: @tile_collection_klass.new(tiles, dimensions),
                       team_collection: @team_collection_klass.new(teams),
                       game_state:      @game_state.new)
    end

    private

    def create_tiles
      cnt = @dimensions ** 2
      (1..cnt).map { |i| @tile_klass.new }
    end
  end
end
