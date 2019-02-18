require "spec_helper"

describe Model::TileCollection do
  let(:tile_collection) {}

  describe :available_tiles do
    context "all tiles available" do
      let(:tile_collection) { build(:tile_collection) }

      it "returns all of them" do
        expect(tile_collection.available_tiles.count).to eq(9)
        expect(tile_collection.available_tiles?).to eq(true)
      end
    end

    context "there are available tiles" do
      let(:tile_collection) { build(:tile_collection) }
      let(:piece) { build(:piece) }

      it "returns only available tiles" do
        tile = tile_collection.find_tile(1,1)
        tile.piece = piece
        expect(tile_collection.available_tiles.count).to eq(8)
        expect(tile_collection.available_tiles?).to eq(true)
      end
    end

    context "there are not available tiles" do
      let(:tile_collection) { build(:tile_collection) }
      let(:piece) { build(:piece) }

      it "returns zero tiles" do
        dimensions = tile_collection.dimensions

        (1..dimensions).each do |row|
          (1..dimensions).each do |col|
            tile = tile_collection.find_tile(row, col)
            tile.piece = piece
          end
        end

        expect(tile_collection.available_tiles.count).to eq(0)
        expect(tile_collection.available_tiles?).to eq(false)
      end
    end
  end

  describe :find_tile do
    context "valid row and col" do
      let(:tile_collection) { build(:tile_collection) }

      it "returns tile" do
        tile = tile_collection.find_tile(2, 2)
        expect(tile.row).to eq(2)
        expect(tile.col).to eq(2)
      end
    end

    context "invalid row and col" do
      let(:tile_collection) { build(:tile_collection) }

      it "returns nil" do
        tile = tile_collection.find_tile(4, 4)
        expect(tile).to eq(nil)
      end
    end
  end

  describe :rows do
    let(:tile_collection) { build(:tile_collection) }

    it "returns array of arrays" do
      tile_collection.rows.each_with_index do |row, i|
        row.each_with_index do |tile, j|
          expect(tile.row).to eq(i + 1)
          expect(tile.col).to eq(j + 1)
        end
      end
    end
  end

  describe :rotate do
    let(:tile_collection) { build(:tile_collection) }

    it "rows become cols" do
      tile_collection.each do |tile|
        piece = build(:piece)
        tile.piece = piece
      end

      rotated = tile_collection.rotate
      dimensions = tile_collection.dimensions
      col_i = dimensions

      (1..dimensions).each do |row|
        (1..dimensions).each do |col|
          rotated_tile = rotated.find_tile(col, col_i)
          tile = tile_collection.find_tile(row, col)

          expect(rotated_tile.piece.name).to eq(tile.piece.name)
        end

        col_i -= 1
      end
    end
  end

  describe :flip do
    let(:tile_collection) { build(:tile_collection) }

    it "top row becomes bottom row" do
      tile_collection.each do |tile|
        piece = build(:piece)
        tile.piece = piece
      end

      dimensions = tile_collection.dimensions
      flipped = tile_collection.flip
      top_row_i = 1
      bottom_row_i = dimensions

      (1..dimensions).each do |col_i|
        flipped_tile = flipped.find_tile(bottom_row_i, col_i)
        tile = tile_collection.find_tile(top_row_i, col_i)
        expect(flipped_tile.piece.name).to eq(tile.piece.name)
      end
    end
  end
end
