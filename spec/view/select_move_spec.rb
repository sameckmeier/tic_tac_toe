require 'spec_helper'

describe View::SelectMove do
  let(:current_team) { double(:current_team, name: 'test') }
  let(:terminal_util) { double(:terminal_util) }
  let(:board_presenter) { double(:board_presenter) }
  let(:select_move_view) { build(:select_move_view, board_presenter: board_presenter, terminal_util: terminal_util) }

  describe :render do
    before do
      allow(board_presenter).to receive(:current_team) { current_team }
    end

    it "renders message indicating that it is a player's turn" do
      expect(select_move_view).to receive(:display_msg).with("Go #{current_team.name}")
      expect(select_move_view).to receive(:select_move)

      select_move_view.render
    end

    context 'when current team is a computer' do
      it 'computer selects move' do
        allow(current_team).to receive(:computer?) { true }

        expect(board_presenter).to receive(:computer_select_move).with(current_team)

        select_move_view.render
      end
    end

    context 'when current team is a human' do
      context 'player selects valid move inputs' do
        it 'renders select move input' do
          allow(current_team).to receive(:computer?) { false }
          allow(select_move_view).to receive(:display_msg)
          allow(terminal_util).to receive(:get_integer_input) { 1 }
          allow(board_presenter).to receive(:invalid_tile_selection?) { false }

          expect(board_presenter).to receive(:select_move).with(1, 1, current_team)

          select_move_view.render
        end
      end

      context 'player selects invalid move inputs' do
        it 'raise InvalidSelection' do
          allow(current_team).to receive(:computer?) { false }
          allow(select_move_view).to receive(:display_msg)
          allow(terminal_util).to receive(:get_integer_input) { 1 }
          allow(board_presenter).to receive(:invalid_tile_selection?) { true }

          expect { select_move_view.render }.to raise_error(InvalidSelection)
        end
      end
    end
  end
end
