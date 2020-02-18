module Model
  class Move
    attr_reader :tile, :piece

    def initialize(tile, piece)
      @tile = tile
      @piece = piece
    end

    class << self
      def generate_moves(piece, board)
        board.available_tiles.map { |tile| generate_move(tile, piece) }
      end
  
      def generate_move(tile, piece)
        self.new(tile, piece)
      end
    end
  end
end
