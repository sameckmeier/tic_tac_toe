module Model
  class Piece
    attr_reader :name
    attr_accessor :team

    def initialize(name, move_klass)
      @name = name
      @move_klass = move_klass
    end

    def moves(board)
      @move_klass.generate_moves(self, board)
    end
  end
end
