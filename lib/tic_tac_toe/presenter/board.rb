module Presenter
  class Board
    def initialize(args)
      @board = args[:board]
      @view = args[:view]
      @game_tree_factory = args[:game_tree_factory]
    end

    def run
      @view.render(default_view_args) while continue?

      args = default_view_args
      winner = @board.winner
      args[:complete] = true
      args[:winner] = winner if winner
      @view.render(args)
    end

    def select_move_input(row, col, team)
      select_move(row, col, team)
    end

    def computer_select_move(team)
      move_strategy = team.move_strategy
      game_tree = @game_tree_factory.generate_game_tree(@board)
      move = move_strategy.select_move(game_tree)
      tile = move.tile
      select_move(tile.row, tile.col, team)
    end

    def tile_available?(row, col)
      @board.tile_available?(row, col)
    end

    private

    def select_move(row, col, team)
      @board.set_piece(row, col, team.selected_piece)
      @board.cycle_teams
    end

    def default_view_args
      { presenter:       self,
        tile_collection: @board.tile_collection,
        team:            @board.current_team }
    end

    def continue?
      !@board.complete?
    end
  end
end
