require 'spec_helper'

describe Model::Tile do
  let!(:row) { 1 }
  let!(:col) { 1 }
  let!(:team) { build(:team) }
  let!(:piece) { build(:piece, team: team, name: 'test') }
  let!(:tile) { build(:tile) }

  describe :available? do
    context 'when piece is nil' do
      it 'return true' do
        expect(tile.available?).to eq(true)
      end
    end

    context 'when piece is present' do
      it 'returns false' do
        tile.piece = piece
        expect(tile.available?).to eq(false)
      end
    end
  end

  describe :team do
    context 'when piece is nil' do
      it 'returns nil' do
        expect(tile.team).to eq(nil)
      end
    end

    context 'when piece is present' do
      it 'returns team' do
        tile.piece = piece
        expect(tile.team).to eq(team)
      end
    end
  end

  describe :piece_name do
    context 'when piece is nil' do
      it 'returns -' do
        expect(tile.piece_name).to eq('-')
      end
    end

    context 'when piece is present' do
      it "returns piece's name" do
        tile.piece = piece
        expect(tile.piece_name).to eq(piece.name)
      end
    end
  end
end
