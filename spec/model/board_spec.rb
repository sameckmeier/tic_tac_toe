require "spec_helper"

describe Model::Board do
  describe :set_piece do
    let(:piece) { double(:piece, name: "test") }
    let(:board) { build(:board) }

    it "sets piece" do
      tile = board.set_piece(1, 1, piece)

      expect(tile.piece.name).to eq(piece.name)
    end
  end

  describe :tile_available? do
    let(:piece) { double(:piece) }
    let(:tile_collection) { double(:tile_collection) }
    let(:tile) { double(:tile) }
    let(:board) { build(:board, tile_collection: tile_collection) }
    
    context "when tile is not available" do
      it "returns false" do
        allow(tile).to receive(:piece) { piece }
        allow(tile_collection).to receive(:find_tile) { tile }
        
        expect(board.tile_available?(1, 1)).to eq(false)
      end
    end

    context "when tile is available" do
      it "returns true" do
        allow(tile).to receive(:piece) { nil }
        allow(tile_collection).to receive(:find_tile) { tile }
        
        expect(board.tile_available?(1, 1)).to eq(true)
      end
    end
  end

  describe :complete? do
    let(:team) { double(:team) }
    let(:tiles) { double(:tiles) }
    let(:game_state) { double(:game_state) }
    let(:tile_collection) { double(:tile_collection) }
    let(:board) { build(:board, tile_collection: tile_collection, game_state: game_state) }
    
    context "when board is not complete" do
      context "when there is not a winner and there are available tiles" do
        it "returns false" do
          allow(tiles).to receive(:count) { 1 }
          allow(game_state).to receive(:winner) { nil }
          allow(tile_collection).to receive(:available_tiles) { tiles }
          
          expect(board.complete?).to eq(false)
        end
      end
    end

    context "when board is complete" do
      context "when there is a winner and available tiles" do
        it "returns true" do
          allow(tiles).to receive(:count) { 1 }
          allow(game_state).to receive(:winner) { team }
          allow(tile_collection).to receive(:available_tiles) { tiles }
          
          expect(board.complete?).to eq(true)
        end
      end

      context "when there is no winner and no available tiles" do
        it "returns true" do
          allow(tiles).to receive(:count) { 0 }
          allow(game_state).to receive(:winner) { nil }
          allow(tile_collection).to receive(:available_tiles) { tiles }
          
          expect(board.complete?).to eq(true)
        end
      end
    end
  end

  describe :rating do
    let(:team) { double(:team) }
    let(:tiles) { double(:tiles) }
    let(:game_state) { double(:game_state) }
    let(:tile_collection) { double(:tile_collection) }
    let(:board) { build(:board, tile_collection: tile_collection, game_state: game_state) }
    
    context "when the game state's rating is < 0" do
      it "subtracts the number of available tiles from the rating" do
        allow(game_state).to receive(:rating) { -1 }
        allow(tiles).to receive(:count) { 1 }
        allow(tile_collection).to receive(:available_tiles) { tiles }

        expect(board.rating(team)).to eq(-2)
      end
    end

    context "when the game state's rating is > 0" do
      it "adds the number of available tiles to the rating" do
        allow(game_state).to receive(:rating) { 1 }
        allow(tiles).to receive(:count) { 1 }
        allow(tile_collection).to receive(:available_tiles) { tiles }
        
        expect(board.rating(team)).to eq(2)
      end
    end
  end
end
