module Model
  class GameTree
    attr_reader :previous_move, :board

    def initialize(board, previous_move = nil)
      @board = board
      @previous_move = previous_move
      @equivalent = {}
    end

    class << self
      def generate_game_tree(board, previous_move = nil)
        self.new(board, previous_move)
      end
    end

    def current_team
      @board.current_team
    end

    def complete?
      @board.complete? || next_game_trees.count == 0
    end

    def rating(team)
      @board.rating(team)
    end

    def next_game_trees
      return @next_game_trees unless @next_game_trees.nil?

      moves = @board.available_moves

      @next_game_trees = moves.each_with_object([]) do |move, game_trees|
        tile = move.tile
        board = @board.clone

        board.set_piece(tile.row, tile.col, move.piece)

        tile_collection = board.tile_collection

        unless equivalent?(tile_collection.id)
          add_equivalents(tile_collection)

          board.cycle_teams

          game_trees << self.class.generate_game_tree(board, move)
        end

        game_trees
      end

      @next_game_trees
    end

    private

    def equivalent?(tile_collection_id)
      @equivalent[tile_collection_id]
    end

    def add_equivalents(tile_collection)
      @equivalent[tile_collection.flip.id] = true

      i = 3
      rotated = tile_collection.rotate

      while i > 0
        @equivalent[rotated.id] = true
        @equivalent[rotated.flip.id] = true
        rotated = rotated.rotate
        i -= 1
      end
    end
  end
end
