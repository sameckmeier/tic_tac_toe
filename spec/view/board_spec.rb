require "spec_helper"

describe View::Board do
  let(:tile_collection) { double(:tile_collection, dimensions: 1, rows: []) }
  let(:board_presenter) { double(:board_presenter) }
  let(:table_klass) { double(:table_klass) }
  let(:table) { double(:table) }
  let(:board_view) { build(:board_view, board_presenter: board_presenter, table_klass: table_klass) }

  describe :render do    
    it "renders board" do
      allow(board_presenter).to receive(:tile_collection) { tile_collection }
      allow(table_klass).to receive(:new) { table }
      expect(board_view).to receive(:generate_headings).with(tile_collection.dimensions)
      expect(board_view).to receive(:format_rows).with(tile_collection.rows)
      expect(board_view).to receive(:display_msg).with(table)

      board_view.render
    end
  end
end
