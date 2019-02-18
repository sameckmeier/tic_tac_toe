module Model
  class Move
    attr_reader :tile, :piece

    def initialize(tile, piece)
      @tile = tile
      @piece = piece
    end
  end
end
