module Model
  class MoveFactory
    def generate_moves(piece, board)
      board.available_tiles.map { |tile| generate_move(tile, piece) }
    end

    def generate_move(tile, piece)
      Model::Move.new(tile, piece)
    end
  end
end
