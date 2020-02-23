require "spec_helper"

describe View::GameResult do
  let(:board_presenter) { double(:board_presenter) }
  let(:game_result_view) { build(:game_result_view, board_presenter: board_presenter) }

  describe :render do  
    context "when it's a draw" do
      it "renders draw" do
        allow(board_presenter).to receive(:draw?) { true }
        expect(game_result_view).to receive(:display_msg).with("Draw!")

        game_result_view.render
      end
    end

    context "when a team wins" do
      let(:winning_team) { double(:winning_team, name: "test") }
      
      it "renders winner" do
        allow(board_presenter).to receive(:draw?) { false }
        allow(board_presenter).to receive(:winner?) { true }
        allow(board_presenter).to receive(:winning_team) { winning_team }
        expect(game_result_view).to receive(:display_msg).with("Team #{winning_team.name} Won!!!")

        game_result_view.render
      end
    end
  end
end
