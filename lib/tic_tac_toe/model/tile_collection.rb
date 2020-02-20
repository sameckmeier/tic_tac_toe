module Model
  class TileCollection
    attr_reader :dimensions

    def initialize(tiles, dimensions)
      raise ArgumentError, "empty tiles array" if tiles.length == 0

      @dimensions = dimensions

      @tiles = tiles.each_with_index do |tile, i|
        tile.col = col_index(i)
        tile.row = row_index(i)
      end
    end

    def id
      @tiles.each_with_object("") do |tile, str|
        str << tile.piece_name
        str
      end
    end

    def each(&block)
      @tiles.each(&block)
    end

    def rows
      return @rows unless @rows.nil?

      i = 0
      @rows = []

      while i < @tiles.count
        j = i + 3

        @rows << @tiles[i...j]
        
        i = j
      end

      @rows
    end

    def available_tiles
      @tiles.find_all(&:available?)
    end

    def available_tiles?
      available_tiles.count > 0
    end

    def find_tile(row, col)
      @tiles[index(row.to_i, col.to_i)]
    end

    def rotate
      tiles = clone_tiles
      rotated = []
      rotated_col_i = dimensions

      (1..dimensions).each do |row_i|
        (1..dimensions).each do |col_i|
          rotate_tile(row_i, col_i, rotated_col_i, rotated, tiles)
        end

        rotated_col_i -= 1
      end

      clone(rotated)
    end

    def flip
      tiles = clone_tiles

      top_row_i = 1
      bottom_row_i = dimensions

      while top_row_i <= (dimensions / 2)
        (1..dimensions).each do |col_i|
          flip_tile(top_row_i, bottom_row_i, col_i, tiles)
        end

        top_row_i += 1
        bottom_row_i -= 1
      end

      clone(tiles)
    end

    def clone(tiles = nil)
      tiles ||= clone_tiles

      self.class.new(tiles, dimensions)
    end

    private

    def flip_tile(top_row_i, bottom_row_i, col_i, tiles)
      top_i = index(top_row_i, col_i)
      bottom_i = index(bottom_row_i, col_i)
      top = tiles[top_i]
      bottom = tiles[bottom_i]

      top.row = bottom_row_i
      bottom.row = top_row_i

      tiles[top_i] = bottom
      tiles[bottom_i] = top
    end

    def rotate_tile(row_i, col_i, rotated_col_i, rotated, tiles)
      tile_i = index(row_i, col_i)
      rotated_tile_i = index(col_i, rotated_col_i)
      tile = tiles[tile_i]

      tile.row = col_i
      tile.col = rotated_col_i

      rotated[rotated_tile_i] = tile
    end

    def clone_tiles
      @tiles.map(&:clone)
    end

    def index(row, col)
      r = row - 1
      c = col - 1

      dimensions * r + c
    end

    def row_index(i)
      (i / dimensions) + 1
    end

    def col_index(i)
      (i % dimensions) + 1
    end
  end
end
