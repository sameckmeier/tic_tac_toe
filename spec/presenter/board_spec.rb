require 'spec_helper'

describe Presenter::Board do
  let!(:team) { double(:team) }
  let!(:game_tree_klass) { double(:game_tree_klass) }
  let!(:board) { double(:board, dimensions: 1) }
  let!(:board_presenter) { build(:board_presenter, game_tree_klass: game_tree_klass, board: board) }

  describe :invalid_tile_selection? do
    context 'when selection is invalid' do
      let!(:board) { double(:board, dimensions: 1) }

      it 'returns true' do
        allow(board).to receive(:tile_available?) { false }
        expect(board_presenter.invalid_tile_selection?(1, 1)).to eq(true)
        expect(board_presenter.invalid_tile_selection?(1, 3)).to eq(true)
        expect(board_presenter.invalid_tile_selection?(3, 1)).to eq(true)
      end
    end

    context 'when selection is valid' do
      it 'returns false' do
        allow(board).to receive(:tile_available?) { true }
        expect(board_presenter.invalid_tile_selection?(1, 1)).to eq(false)
      end
    end
  end

  describe :winner? do
    context 'when there is a winning team' do
      let(:team) { double(:team) }
      it 'returns true' do
        allow(team).to receive(:nil?) { false }
        allow(board).to receive(:winner) { team }
        expect(board_presenter.winner?).to eq(true)
      end
    end

    context 'when there is not a winning team' do
      it 'returns false' do
        allow(board).to receive(:winner) { nil }
        expect(board_presenter.winner?).to eq(false)
      end
    end
  end

  describe :continue? do
    context 'when there is a draw' do
      it 'returns false' do
        allow(board).to receive(:winner) { nil }
        allow(board).to receive(:complete?) { true }
        expect(board_presenter.continue?).to eq(false)
      end
    end

    context 'when there is a winner' do
      it 'returns false' do
        allow(team).to receive(:nil?) { false }
        allow(board).to receive(:winner) { team }
        allow(board).to receive(:complete?) { true }
        expect(board_presenter.continue?).to eq(false)
      end
    end

    context 'when there is not a draw or winner' do
      it 'returns true' do
        allow(board).to receive(:winner) { nil }
        allow(board).to receive(:complete?) { false }
        expect(board_presenter.continue?).to eq(true)
      end
    end
  end

  describe :draw? do
    context 'when there is a draw' do
      it 'returns true' do
        allow(board).to receive(:winner) { nil }
        allow(board).to receive(:complete?) { true }
        expect(board_presenter.draw?).to eq(true)
      end
    end

    context 'when there is not a draw' do
      it 'returns false' do
        allow(team).to receive(:nil?) { false }
        allow(board).to receive(:winner) { team }
        allow(board).to receive(:complete?) { true }
        expect(board_presenter.draw?).to eq(false)
      end
    end
  end
end
