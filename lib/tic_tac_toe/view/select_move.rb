module View
  class SelectMove < View::Base
    SELECT_ROW_MESSAGE = "Please select a row"
    SELECT_COL_MESSAGE = "Please select a col"

    def initialize(board_presenter, terminal_util)
      @board_presenter = board_presenter
      @terminal_util = terminal_util
    end
    
    def render
      display_msg("Go #{@board_presenter.current_team.name}")

      select_move
    end

    private

    def select_move
      current_team = @board_presenter.current_team

      if current_team.computer?
        @board_presenter.computer_select_move(current_team)
      else
        display_msg(SELECT_ROW_MESSAGE)

        row = @terminal_util.get_integer_input

        display_msg(SELECT_COL_MESSAGE)
        
        col = @terminal_util.get_integer_input

        if @board_presenter.invalid_tile_selection?(row, col)
          raise InvalidSelection, "Invalid Tile Selection :(" 
        else
          @board_presenter.select_move(row, col, current_team)
        end
      end
    end
  end
end
