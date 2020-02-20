require "spec_helper"

describe Model::GameState do
  let(:dimensions) { 3 }
  let(:range) { (1..dimensions) }
  let!(:tile_collection) { double(:tile_collection, dimensions: dimensions) }
  let!(:board) { double(:board, tile_collection: tile_collection) }
  let!(:empty_tile) { double(:tile, team: nil) }
  let!(:team) { double(:team, name: "test") }
  let!(:opposing_team) { double(:team, name: "another test") }
  let!(:tile) { double(:tile, team: team) }
  let!(:opposing_tile) { double(:tile, team: opposing_team) }
  let!(:game_state) { build(:game_state) }

  before { allow(tile_collection).to receive(:find_tile).and_return(empty_tile) }

  describe :winner do
    context "when there is a winning team" do
      context "diagonal" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(i, i).and_return(tile) }
          expect(game_state.winner(board).name).to eq team.name
        end
      end

      context "row" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(1, i).and_return(tile) }
          expect(game_state.winner(board).name).to eq team.name
        end
      end

      context "col" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(i, 1).and_return(tile) }
          expect(game_state.winner(board).name).to eq team.name
        end
      end
    end

    context "when there is not winning team" do
      context "diagonal" do
        it "returns nil" do
          range.each do |i|
            t = i.odd? ? tile : opposing_tile
            allow(tile_collection).to receive(:find_tile).with(i, i).and_return(t)
          end

          expect(game_state.winner(board)).to eq nil
        end
      end

      context "row" do
        it "returns nil" do
          range.each do |i|
            t = i.odd? ? tile : opposing_tile
            allow(tile_collection).to receive(:find_tile).with(1, i).and_return(t)
          end

          expect(game_state.winner(board)).to eq nil
        end
      end

      context "col" do
        it "returns nil" do
          range.each do |i|
            t = i.odd? ? tile : opposing_tile
            allow(tile_collection).to receive(:find_tile).with(i, 1).and_return(t)
          end

          expect(game_state.winner(board)).to eq nil
        end
      end
    end
  end

  describe :rating do
    context "when there is a winning team" do
      context "diagonal" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(i, i).and_return(tile) }
          expect(game_state.rating(board, team)).to eq 1
        end
      end

      context "row" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(1, i).and_return(tile) }
          expect(game_state.rating(board, team)).to eq 1
        end
      end

      context "col" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(i, 1).and_return(tile) }
          expect(game_state.rating(board, team)).to eq 1
        end
      end
    end

    context "when there is not winning team" do
      context "diagonal" do
        it "returns nil" do
          range.each do |i|
            t = i.odd? ? tile : opposing_tile
            allow(tile_collection).to receive(:find_tile).with(i, i).and_return(t)
          end

          expect(game_state.rating(board, team)).to eq 0
        end
      end

      context "row" do
        it "returns nil" do
          range.each do |i|
            t = i.odd? ? tile : opposing_tile
            allow(tile_collection).to receive(:find_tile).with(1, i).and_return(t)
          end

          expect(game_state.rating(board, team)).to eq 0
        end
      end

      context "col" do
        it "returns nil" do
          range.each do |i|
            t = i.odd? ? tile : opposing_tile
            allow(tile_collection).to receive(:find_tile).with(i, 1).and_return(t)
          end

          expect(game_state.rating(board, team)).to eq 0
        end
      end
    end

    context "when there is a losing team" do
      context "diagonal" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(i, i).and_return(opposing_tile) }
          expect(game_state.rating(board, team)).to eq -1
        end
      end

      context "row" do
        it "returns winning team" do
          range.each { |i|  allow(tile_collection).to receive(:find_tile).with(1, i).and_return(opposing_tile) }
          expect(game_state.rating(board, team)).to eq -1
        end
      end

      context "col" do
        it "returns winning team" do
          range.each { |i| allow(tile_collection).to receive(:find_tile).with(i, 1).and_return(opposing_tile) }
          expect(game_state.rating(board, team)).to eq -1
        end
      end
    end
  end
end
