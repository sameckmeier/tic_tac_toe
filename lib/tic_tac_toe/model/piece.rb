module Model
  class Piece
    attr_reader :name
    attr_accessor :team

    def initialize(name, move_factory)
      @name = name
      @move_factory = move_factory
    end

    def moves(board)
      @move_factory.generate_moves(self, board)
    end
  end
end
