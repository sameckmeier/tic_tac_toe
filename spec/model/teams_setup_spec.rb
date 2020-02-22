require "spec_helper"

describe Model::TeamsSetup do
  let!(:team_klass) { double(:team_klass) }
  let!(:piece_klass) { double(:piece_klass) }
  let!(:move_klass) { double(:move_klass) }
  let!(:move_strategy_klass) { double(:move_strategy_klass) }
  let!(:teams_setup) do
    build(
      :teams_setup,
      team_klass: team_klass,
      piece_klass: piece_klass,
      move_klass: move_klass,
      move_strategy_klass: move_strategy_klass
    )
    end

  describe :valid_team_type? do
    context "when type is valid" do
      it "returns true" do
        expect(teams_setup.valid_team_type?(1)).to eq(true)
        expect(teams_setup.valid_team_type?(2)).to eq(true)
      end
    end

    context "when type is not valid" do
      it "returns false" do
        expect(teams_setup.valid_team_type?(3)).to eq(false)
      end
    end
  end

  describe :create_teams do
    let(:move_strategy) { double(:move_strategy) }
    let(:piece) { double(:piece) }
    let(:team) { double(:team) }

    it "returns an array of teams" do
      expect(move_strategy_klass).to receive(:new) { move_strategy }
      allow(piece_klass).to receive(:new) { piece }
      allow(team_klass).to receive(:new) { team }

      teams = teams_setup.create_teams([{ name: "X", type: 1 }, { name: "O", type: 2 }])
      expect(teams.length).to eq(2)
    end
  end
end
