module View
  class Board
    def render(args)
      clear_screen
      puts message(args)
      puts table(args[:tile_collection])
      select_move(args[:complete], args[:team], args[:presenter])
    end

    private

    def clear_screen
      system("clear") || system("cls")
    end

    def message(args)
      if args[:complete]
        args[:winner] ? "Team #{args[:winner].name} Won!!!" : "Draw!"
      else
        "Go #{args[:team].name}"
      end
    end

    def table(tile_collection)
      headings = generate_headings(tile_collection.dimensions)
      rows = format_rows(tile_collection.rows)

      Terminal::Table.new(headings: headings, rows: rows, style: { all_separators: true })
    end

    def select_move(complete, team, presenter)
      return if complete

      if team.computer?
        presenter.computer_select_move(team)
      else
        puts "Please select a row"
        row = gets.chomp
        puts "Please select a column"
        col = gets.chomp

        if presenter.tile_available?(row, col)
          presenter.select_move_input(row, col, team)
        else
          puts "Invalid Selection: Tile has already been selected"
          select_move(complete, team, presenter)
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
