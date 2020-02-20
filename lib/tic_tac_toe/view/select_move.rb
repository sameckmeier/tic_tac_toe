module View
  class SelectMove < View::Terminal
    def render
      puts "Go #{@presenter.current_team.name}"

      select_move
    end

    private

    def select_move
      begin
        current_team = @presenter.current_team

        if current_team.computer?
          @presenter.computer_select_move(current_team)
        else
          puts "Please select a row"

          row = @terminal_util.get_integer_input

          puts "Please select a column"
          
          col = @terminal_util.get_integer_input

          if @presenter.invalid_tile_selection?(row, col)
            raise InvalidSelection, "Invalid Tile Selection :(" 
          else
            @presenter.select_move(row, col, current_team)
          end
        end
      rescue InvalidSelection => e
        puts e.message
        retry
      end
    end
  end
end
