module View
  class SelectMove < View::Terminal
    def render
      puts "Go #{@controller.current_team.name}"
      select_move
    end

    private

    def select_move
      current_team = @controller.current_team

      if current_team.computer?
        @controller.computer_select_move(current_team)
      else
        puts "Please select a row"
        row = @terminal_util.get_input
        puts "Please select a column"
        col = @terminal_util.get_input

        if @controller.tile_available?(row, col)
          @controller.select_move(row, col, current_team)
        else
          puts "Invalid Selection: Tile has already been selected"
          select_move
        end
      end
    end
  end
end