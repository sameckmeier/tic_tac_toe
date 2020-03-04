require 'spec_helper'

describe Model::GameTree do
  describe :complete? do
    let!(:board) { double(:board) }
    let!(:game_tree) { build(:game_tree, board: board) }

    context 'when board is complete' do
      it 'returns true' do
        allow(board).to receive(:complete?) { true }
        expect(game_tree.complete?).to eq(true)
      end
    end

    context 'when there are no more game trees' do
      let(:next_game_trees) { double(:next_game_trees, count: 0) }

      it 'returns true' do
        allow(board).to receive(:complete?) { false }
        allow(game_tree).to receive(:next_game_trees) { next_game_trees }
        expect(game_tree.complete?).to eq(true)
      end
    end

    context 'when game_tree is not complete' do
      let(:next_game_trees) { double(:next_game_trees, count: 1) }

      it 'returns false' do
        allow(board).to receive(:complete?) { false }
        allow(game_tree).to receive(:next_game_trees) { next_game_trees }
        expect(game_tree.complete?).to eq(false)
      end
    end
  end

  describe :next_game_trees do
    context 'when there are available moves' do
      let(:tile) { double(:tile, row: 1, col: 1) }
      let(:piece) { double(:piece) }
      let(:moves) { [double(:move, tile: tile, piece: piece)] }
      let(:tile_collection) { double(:tile_collection, id: 1) }
      let(:board) { double(:board, tile_collection: tile_collection) }
      let(:game_tree) { build(:game_tree, board: board) }

      it 'returns a game_tree for each available tile' do
        allow(board).to receive(:available_moves) { moves }
        allow(board).to receive(:clone) { board }
        allow(board).to receive(:set_piece)
        allow(board).to receive(:cycle_teams)
        allow(tile_collection).to receive(:equivalents) { [] }

        expect(game_tree.next_game_trees.count).to eq(1)
      end
    end

    context 'when there are no available moves' do
      let(:moves) { [] }
      let(:board) { double(:board) }
      let(:game_tree) { build(:game_tree, board: board) }

      it 'returns an empty array' do
        allow(board).to receive(:available_moves) { moves }
        expect(game_tree.next_game_trees.count).to eq(0)
      end
    end
  end
end
