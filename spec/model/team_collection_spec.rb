require "spec_helper"

require "spec_helper"

describe Model::TeamCollection do
  let!(:team_a) { double(:team_a) }
  let!(:team_b) { double(:team_b) }
  let!(:teams) { [team_a, team_b] }
  let!(:team_collection) { build(:team_collection, teams: teams) }

  describe :current do
    it "teams head" do
      expect(team_collection.current).to eq(team_a)
    end
  end

  describe :next do
    it "cycles teams" do
      team_collection.next
      expect(team_collection.current).to eq(team_b)
    end
  end
end
