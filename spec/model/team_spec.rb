require 'spec_helper'

describe Model::Team do
  let!(:piece) { double(:piece, team: nil) }
  let!(:pieces) { [piece] }
  let!(:name) { 'test' }
  let!(:move_strategy) { double(:move_strategy) }

  before do
    allow(piece).to receive(:team=)
  end

  describe :initialize do
    context 'pieces is an empty array' do
      it 'raise an ArguementError' do
        expect { build(:team, pieces: []) }.to raise_error(ArgumentError)
      end
    end
  end

  describe :selected_piece do
    let(:team) { build(:team_with_move_strategy, pieces: pieces, move_strategy: move_strategy) }

    it 'returns head piece from pieces' do
      expect(team.selected_piece).to eq(piece)
    end
  end

  describe :computer? do
    context 'when team is a computer' do
      let(:team) { build(:team_with_move_strategy, pieces: pieces, move_strategy: move_strategy) }

      it 'returns true' do
        expect(team.computer?).to eq(true)
      end
    end

    context 'when team is a human' do
      let(:team) { build(:team_with_move_strategy, pieces: pieces, move_strategy: nil) }

      it 'returns false' do
        expect(team.computer?).to eq(false)
      end
    end
  end

  describe :available_moves do
    let(:move) { double(:move) }
    let(:board) { double(:board) }
    let(:team) { build(:team_with_move_strategy, pieces: pieces) }

    it 'returns equivalent tile_collections' do
      allow(piece).to receive(:moves) { [move] }
      expect(team.available_moves(board).count).to eq(1)
    end
  end
end
