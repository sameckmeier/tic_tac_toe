module Model
  class Tile
    attr_accessor :piece, :row, :col

    def available?
      piece.nil?
    end

    def team
      piece&.team
    end

    def piece_name
      piece ? piece.name : '-'
    end
  end
end
