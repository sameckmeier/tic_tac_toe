require "spec_helper"

describe Model::GameState do
  describe :winner do
    let(:game_state) { build(:game_state) }
    let(:board) { build(:board, game_state: game_state) }
    let(:dimensions) { board.tile_collection.dimensions }
    let(:range) { (1..dimensions) }

    context "when there is a winning team" do
      let(:team) { board.current_team }
      let(:piece) { team.pieces[0] }

      context "diagonal" do
        it "returns winning team" do
          range.each { |i| board.set_piece(i, i, piece) }
          expect(game_state.winner(board).name).to eq team.name
        end
      end

      context "row" do
        it "returns winning team" do
          range.each { |i| board.set_piece(1, i, piece) }
          expect(game_state.winner(board).name).to eq team.name
        end
      end

      context "col" do
        it "returns winning team" do
          range.each { |i| board.set_piece(i, 1, piece) }
          expect(game_state.winner(board).name).to eq team.name
        end
      end
    end

    context "when there is not winning team" do
      let(:team) { build(:team) }
      let(:opposing_team) { build(:team) }
      let(:team_collection) { build(:team_collection, teams: [team, opposing_team]) }
      let(:piece) { team.pieces[0] }
      let(:opposing_team_piece) { opposing_team.pieces[0] }
      let(:board) { build(:board, game_state: game_state, team_collection: team_collection) }

      it "returns nil" do
        expect(board.winner).to eq nil
      end

      context "diagonal" do
        it "returns nil" do
          range.each do |i|
            p = i.odd? ? piece : opposing_team_piece
            board.set_piece(i, i, p)
          end

          expect(game_state.winner(board)).to eq nil
        end
      end

      context "row" do
        it "returns nil" do
          range.each do |i|
            p = i.odd? ? piece : opposing_team_piece
            board.set_piece(1, i, p)
          end

          expect(game_state.winner(board)).to eq nil
        end
      end

      context "col" do
        it "returns nil" do
          range.each do |i|
            p = i.odd? ? piece : opposing_team_piece
            board.set_piece(i, 1, p)
          end

          expect(game_state.winner(board)).to eq nil
        end
      end
    end
  end

  describe :rating do
    let(:game_state) { build(:game_state) }
    let(:board) { build(:board, game_state: game_state) }
    let(:dimensions) { board.tile_collection.dimensions }
    let(:range) { (1..dimensions) }

    context "when there is a winning team" do
      let(:team) { board.current_team }
      let(:piece) { team.pieces[0] }

      context "diagonal" do
        it "returns winning team" do
          range.each { |i| board.set_piece(i, i, piece) }
          expect(game_state.rating(board, team)).to eq 1
        end
      end

      context "row" do
        it "returns winning team" do
          range.each { |i| board.set_piece(1, i, piece) }
          expect(game_state.rating(board, team)).to eq 1
        end
      end

      context "col" do
        it "returns winning team" do
          range.each { |i| board.set_piece(i, 1, piece) }
          expect(game_state.rating(board, team)).to eq 1
        end
      end
    end

    context "when there is not winning team" do
      let(:team) { build(:team) }
      let(:opposing_team) { build(:team) }
      let(:team_collection) { build(:team_collection, teams: [team, opposing_team]) }
      let(:piece) { team.pieces[0] }
      let(:opposing_team_piece) { opposing_team.pieces[0] }
      let(:board) { build(:board, game_state: game_state, team_collection: team_collection) }

      it "returns nil" do
        expect(game_state.rating(board, team)).to eq 0
      end

      context "diagonal" do
        it "returns nil" do
          range.each do |i|
            p = i.odd? ? piece : opposing_team_piece
            board.set_piece(i, i, p)
          end

          expect(game_state.rating(board, team)).to eq 0
        end
      end

      context "row" do
        it "returns nil" do
          range.each do |i|
            p = i.odd? ? piece : opposing_team_piece
            board.set_piece(1, i, p)
          end

          expect(game_state.rating(board, team)).to eq 0
        end
      end

      context "col" do
        it "returns nil" do
          range.each do |i|
            p = i.odd? ? piece : opposing_team_piece
            board.set_piece(i, 1, p)
          end

          expect(game_state.rating(board, team)).to eq 0
        end
      end
    end

    context "when there is a losing team" do
      let(:game_state) { build(:game_state) }
      let(:board) { build(:board, game_state: game_state) }
      let(:dimensions) { board.tile_collection.dimensions }
      let(:range) { (1..dimensions) }
      let!(:team) { board.current_team }
      let!(:piece) { team.pieces[0] }

      context "diagonal" do
        it "returns winning team" do
          board.cycle_teams
          next_team = board.current_team
          range.each { |i| board.set_piece(i, i, piece) }
          expect(game_state.rating(board, next_team)).to eq -1
        end
      end

      context "row" do
        it "returns winning team" do
          board.cycle_teams
          next_team = board.current_team
          range.each { |i| board.set_piece(1, i, piece) }
          expect(game_state.rating(board, next_team)).to eq -1
        end
      end

      context "col" do
        it "returns winning team" do
          board.cycle_teams
          next_team = board.current_team
          range.each { |i| board.set_piece(i, 1, piece) }
          expect(game_state.rating(board, next_team)).to eq -1
        end
      end
    end
  end
end
