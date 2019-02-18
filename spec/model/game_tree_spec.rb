require "spec_helper"

describe Model::GameTree do
  describe :next_game_trees do
    let(:game_tree) { build(:game_tree) }

    it "returns a game_tree for each available tile" do
      next_game_trees = game_tree.next_game_trees
      expect(next_game_trees.count).to eq(3)
    end

    context "when there are no available tiles" do
      let(:team_collection) { build(:team_collection) }
      let(:team) { team_collection.current }
      let(:piece) { team.pieces[0] }
      let(:tile_collection) { build(:tile_collection) }
      let(:dimensions) { tile_collection.dimensions }
      let(:board) { build(:board, team_collection: team_collection, tile_collection: tile_collection) }
      let(:game_tree) { build(:game_tree, board: board) }

      it "returns an empty array" do
        (1..dimensions).each do |row_i|
          (1..dimensions).each do |col_i|
            board.set_piece(row_i, col_i, piece)
          end
        end

        expect(game_tree.next_game_trees.count).to eq(0)
      end
    end
  end
end
