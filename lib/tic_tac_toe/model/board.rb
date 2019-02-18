module Model
  class Board
    attr_reader :tile_collection

    def initialize(args)
      @tile_collection = args[:tile_collection]
      @team_collection = args[:team_collection]
      @game_state = args[:game_state]
    end

    def dimensions
      @tile_collection.dimensions
    end

    def set_piece(row, col, piece)
      tile = @tile_collection.find_tile(row, col)
      tile.piece = piece
    end

    def tile_available?(row, col)
      tile = @tile_collection.find_tile(row, col)
      tile.piece.nil?
    end

    def available_moves
      current_team.available_moves(self)
    end

    def available_tiles
      @tile_collection.available_tiles
    end

    def complete?
      available_tiles.count == 0 || winner
    end

    def current_team
      @team_collection.current
    end

    def cycle_teams
      @team_collection.next
    end

    def winner
      @game_state.winner(self)
    end

    def rating(team)
      rating = @game_state.rating(self, team)

      if rating < 0
       rating -= available_tiles.count
     elsif rating > 0
       rating += available_tiles.count
     end

      rating
    end

    def clone
      self.class.new(tile_collection: @tile_collection.clone,
                     team_collection: @team_collection.clone,
                     game_state:      @game_state.clone)
    end
  end
end
