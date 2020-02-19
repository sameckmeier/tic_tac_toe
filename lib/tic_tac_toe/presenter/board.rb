module Presenter
  class Board
    def initialize(board, game_tree_klass)
      @board = board
      @game_tree_klass = game_tree_klass
    end

    def select_move(row, col, team)
      @board.set_piece(row, col, team.selected_piece)
      @board.cycle_teams
    end

    def computer_select_move(team)
      move_strategy = team.move_strategy
      game_tree = @game_tree_klass.generate_game_tree(@board)
      move = move_strategy.select_move(game_tree)
      tile = move.tile
      select_move(tile.row, tile.col, team)
    end

    def invalid_tile_selection?(row, col)
      row > @board.dimensions || col > @board.dimensions || !@board.tile_available?(row, col)
    end

    def tile_collection
      @board.tile_collection
    end

    def winning_team
      @board.winner
    end

    def current_team
      @board.current_team
    end

    def winner?
      winning_team
    end

    def continue?
      !(draw? || winner?)
    end

    def draw?
      @board.complete? && !winner?
    end
  end
end
