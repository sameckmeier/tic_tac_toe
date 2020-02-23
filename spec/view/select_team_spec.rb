require "spec_helper"

describe View::SelectTeam do
  let(:type) { 1 }
  let(:name) { "test" }
  let(:team_types) { double(:team_types) }
  let(:terminal_util) { double(:terminal_util) }
  let(:select_team_presenter) { double(:select_team_presenter) }
  let(:select_team_view) { build(:select_team_view, select_team_presenter: select_team_presenter, terminal_util: terminal_util) }

  describe :render do
    before do
      allow(team_types).to receive(:each)
      allow(terminal_util).to receive(:get_integer_input) { type }
      allow(terminal_util).to receive(:get_input) { name }
      allow(select_team_presenter).to receive(:team_types) { team_types }
      allow(select_team_presenter).to receive(:invalid_team_selection?) { false }
      allow(select_team_view).to receive(:display_msg)
    end

    it "renders team selection options" do
      expect(select_team_presenter).to receive(:set_teams).with([{ type: type, name: name }, { type: type, name: name }])
      
      select_team_view.render
    end

    context "when a player makes an invalid selection" do 
      it "raise an InvalidSection error" do
        allow(select_team_presenter).to receive(:invalid_team_selection?) { true }

        expect { select_team_view.render }.to raise_error(InvalidSelection)
      end
    end
  end
end
