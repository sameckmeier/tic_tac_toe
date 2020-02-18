module View
  class Board < View::Base
    def render
      puts message
      puts table

      return if !@controller.continue?

      select_move
    end

    private

    def message
      if !@controller.continue?
        @controller.winner ? "Team #{@controller.winner.name} Won!!!" : "Draw!"
      else
        "Go #{@controller.current.name}"
      end
    end

    def table
      headings = generate_headings(tile_collection.dimensions)
      rows = format_rows(tile_collection.rows)

      Terminal::Table.new(headings: headings, rows: rows, style: { all_separators: true })
    end

    def select_move
      current_team = @controller.current_team

      if current_team.computer?
        @controller.computer_select_move(current_team)
      else
        puts "Please select a row"
        row = gets.chomp
        puts "Please select a column"
        col = gets.chomp

        if @controller.tile_available?(row, col)
          @controller.select_move_input(row, col, team)
        else
          puts "Invalid Selection: Tile has already been selected"
          select_move
        end
      end
    end

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
