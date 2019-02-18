require "spec_helper"

describe Model::Board do
  describe :set_piece do
    let(:team_collection) { build(:team_collection) }
    let(:team) { team_collection.current }
    let(:piece) { team.pieces[0] }
    let(:board) { build(:board, team_collection: team_collection) }

    it "sets piece" do
      board.set_piece(1, 1, piece)
      tile = board.tile_collection.find_tile(1, 1)
      tile.piece.name == piece.name
    end
  end
end
