require "spec_helper"

describe Model::TileCollection do
  let!(:tile_collection) { build(:tile_collection) }

  describe :initialize do
    context "tiles is an empty array" do
      it "raise an ArguementError" do
        expect { build(:tile_collection, tiles: []) }.to raise_error(ArgumentError)
      end
    end
  end

  describe :equivalent do
    it "returns equivalent tile_collections" do
      expect(tile_collection.equivalents.count).to eq(8)
    end
  end

  describe :available_tiles do
    context "all tiles available" do
      let(:tile) { double(:tile) }

      it "returns all of them" do
        allow(tile).to receive(:row=)
        allow(tile).to receive(:col=)
        allow(tile).to receive(:available?) { true }

        tile_collection = build(:tile_collection, tiles: [tile], dimensions: 1)

        expect(tile_collection.available_tiles.count).to eq(1)
        expect(tile_collection.available_tiles?).to eq(true)
      end
    end

    context "there are available tiles" do
      let(:tiles) do 
        4.times.each_with_object([]) do |i, arr|
          arr << double(:tile, id: i)
          arr
        end
      end

      it "returns only available tiles" do
        tiles.each do |tile|
          allow(tile).to receive(:row=)
          allow(tile).to receive(:col=)
          allow(tile).to receive(:available?) { tile.id.odd? }
        end
        
        tile_collection = build(:tile_collection, tiles: tiles, dimensions: 2)

        expect(tile_collection.available_tiles.count).to eq(2)
        expect(tile_collection.available_tiles?).to eq(true)
      end
    end

    context "there are no available tiles" do
      let(:tile) { double(:tile) }

      it "returns zero tiles" do
        allow(tile).to receive(:row=)
        allow(tile).to receive(:col=)
        allow(tile).to receive(:available?) { false }

        tile_collection = build(:tile_collection, tiles: [tile], dimensions: 1)

        expect(tile_collection.available_tiles.count).to eq(0)
        expect(tile_collection.available_tiles?).to eq(false)
      end
    end
  end

  describe :find_tile do
    context "valid row and col" do
      let(:tile) { double(:tile, row: 1, col: 1) }

      it "returns tile" do
        allow(tile).to receive(:row=)
        allow(tile).to receive(:col=)

        tile_collection = build(:tile_collection, tiles: [tile], dimensions: 1)
        tile = tile_collection.find_tile(1, 1)

        expect(tile.row).to eq(1)
        expect(tile.col).to eq(1)
      end
    end

    context "invalid row and col" do
      let(:tile) { double(:tile, row: 1, col: 1) }

      it "returns nil" do
        allow(tile).to receive(:row=)
        allow(tile).to receive(:col=)
        allow(tile).to receive(:row)
        allow(tile).to receive(:col)

        tile_collection = build(:tile_collection, tiles: [tile], dimensions: 1)
        tile = tile_collection.find_tile(4, 4)

        expect(tile).to eq(nil)
      end
    end
  end

  describe :rows do
    it "returns array of arrays" do
      tile_collection.rows.each_with_index do |row, i|
        row.each_with_index do |tile, j|
          expect(tile.row).to eq(i + 1)
          expect(tile.col).to eq(j + 1)
        end
      end
    end
  end
end
