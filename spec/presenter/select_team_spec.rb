require 'spec_helper'

describe Presenter::SelectTeam do
  let!(:board_setup) { double(:board_setup) }
  let!(:teams_setup) { double(:teams_setup) }
  let!(:select_team_presenter) { build(:select_team_presenter, board_setup: board_setup, teams_setup: teams_setup) }

  describe :invalid_tile_selection? do
    context 'when selection is invalid' do
      it 'returns true' do
        allow(teams_setup).to receive(:valid_team_type?) { false }
        expect(select_team_presenter.invalid_team_selection?(1)).to eq(true)
      end
    end

    context 'when selection is valid' do
      it 'returns false' do
        allow(teams_setup).to receive(:valid_team_type?) { true }
        expect(select_team_presenter.invalid_team_selection?(1)).to eq(false)
      end
    end
  end

  describe :set_teams do
    let(:teams) { double(:teams) }
    let(:team_args) { double(:team_args) }

    it 'returns true' do
      allow(teams_setup).to receive(:create_teams) { teams }
      expect(board_setup).to receive(:teams=)
      select_team_presenter.set_teams(team_args)
    end
  end
end
