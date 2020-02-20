require "spec_helper"

describe Model::GameTree do
  describe :complete? do
    let!(:board) { double(:board) }
    let!(:game_tree) { build(:game_tree, board: board) }

    context "when board is complete" do
      it "returns true" do
        allow(board).to receive(:complete?) { true }
        expect(game_tree.complete?).to eq(true)
      end
    end

    context "when there are no more game trees" do
      let(:next_game_trees) { double(:next_game_trees, count: 0) }

      it "returns true" do
        allow(board).to receive(:complete?) { false }
        allow(game_tree).to receive(:next_game_trees) { next_game_trees }
        expect(game_tree.complete?).to eq(true)
      end
    end

    context "when game_tree is not complete" do
      let(:next_game_trees) { double(:next_game_trees, count: 1) }

      it "returns false" do
        allow(board).to receive(:complete?) { false }
        allow(game_tree).to receive(:next_game_trees) { next_game_trees }
        expect(game_tree.complete?).to eq(false)
      end
    end
  end

  describe :next_game_trees do
    let(:game_tree) { build(:game_tree) }

    context "when there are available tiles" do
      it "returns a game_tree for each available tile" do
        next_game_trees = game_tree.next_game_trees
        expect(next_game_trees.count).to eq(3)
      end
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
