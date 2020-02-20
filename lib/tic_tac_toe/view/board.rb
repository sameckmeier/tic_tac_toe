module View
  class Board < View::Base
    def initialize(presenter, table_klass)
      super(presenter)

      @table_klass = table_klass
    end

    def render
      tile_collection = @presenter.tile_collection
      headings = generate_headings(tile_collection.dimensions)
      rows = format_rows(tile_collection.rows)
      table = @table_klass.new(headings: headings, rows: rows, style: { all_separators: true })

      puts table
    end

    private

    def generate_indexes(dimensions)
      range = (1..dimensions)

      range.each_with_object([""]) { |i, indexes| indexes << i }
    end

    def generate_headings(dimensions)
      generate_indexes(dimensions)
    end

    def format_rows(rows)
      rows.each_with_object([]).with_index do |(row, arr), i|
        formatted = format_row(row)

        formatted.unshift(i + 1)

        arr << formatted
      end
    end

    def format_row(row)
      formatted = row.map do |tile|
        piece = tile.piece

        piece.nil? ? "" : piece.name
      end

      formatted
    end
  end
end
