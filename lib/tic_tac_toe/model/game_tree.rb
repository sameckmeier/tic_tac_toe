# GameTree is an n-ary tree and produces its children dynamically.

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
        new(board, previous_move)
      end
    end

    def current_team
      @board.current_team
    end

    def complete?
      @board.complete? || next_game_trees.count.zero?
    end

    def rating(team)
      @board.rating(team)
    end

    # Produces children based on the number of unique tile collection orientations.
    # For more info, check out Model::TileCollection.
    def next_game_trees
      return @next_game_trees unless @next_game_trees.nil?

      moves = @board.available_moves

      @next_game_trees = moves.each_with_object([]) { |move, game_trees| add_game_trees(game_trees, move) }

      @next_game_trees
    end

    private

    def add_game_trees(game_trees, move)
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

    def equivalent?(tile_collection_id)
      @equivalent[tile_collection_id]
    end

    def add_equivalents(tile_collection)
      tile_collection.equivalents.each { |tc| @equivalent[tc.id] = true }
    end
  end
end
