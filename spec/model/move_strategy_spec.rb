require "spec_helper"

describe Model::MoveStrategy do
  let(:team) { build(:team_with_move_strategy, name: "X") }
  let(:move_strategy) { team.move_strategy }
  let(:opposing_team) { build(:team, name: "O") }
  let(:team_collection) { build(:team_collection, teams: [team, opposing_team]) }
  let(:piece) { team.pieces[0] }
  let(:opposing_team_piece) { opposing_team.pieces[0] }
  let(:board) { build(:board, team_collection: team_collection) }
  let(:dimensions) { board.tile_collection.dimensions }
  let(:game_tree) { build(:game_tree, board: board) }

  describe :select_move do
    context "there is a winning move" do
      context "row" do
        let(:range) { (1..(dimensions - 1)) }

        it "selects winning move" do
          range.each { |i| board.set_piece(1, i, piece) }
          selected_move = move_strategy.select_move(game_tree)
          expect(selected_move.tile.row).to eq 1
          expect(selected_move.tile.col).to eq 3
          expect(selected_move.piece).to eq piece
        end
      end

      context "column" do
        it "selects winning move" do
          board.set_piece(1, 1, opposing_team_piece)
          board.set_piece(1, 2, piece)
          board.set_piece(1, 3, opposing_team_piece)
          board.set_piece(2, 2, piece)
          board.set_piece(3, 1, opposing_team_piece)

          selected_move = move_strategy.select_move(game_tree)
          expect(selected_move.tile.row).to eq 3
          expect(selected_move.tile.col).to eq 2
          expect(selected_move.piece).to eq piece
        end
      end
    end

    context "there is a losing move" do
      it "selects move that prevents losing" do
        board.set_piece(1, 1, piece)
        board.set_piece(1, 2, piece)
        board.set_piece(1, 3, opposing_team_piece)
        board.set_piece(2, 2, opposing_team_piece)

        selected_move = move_strategy.select_move(game_tree)
        expect(selected_move.tile.row).to eq 3
        expect(selected_move.tile.col).to eq 1
        expect(selected_move.piece).to eq piece
      end
    end

    context "there are only neutral moves" do
      it "selects most advantageous move" do
        selected_move = move_strategy.select_move(game_tree)
        expect(selected_move.tile.row).to eq 1
        expect(selected_move.tile.col).to eq 1
        expect(selected_move.piece).to eq piece
      end
    end
  end
end
