module View
  class GameResult < View::Base
    def initialize(board_presenter)
      @board_presenter = board_presenter
    end

    def render
      if @board_presenter.draw?
        display_msg("Draw!")
      elsif @board_presenter.winner?
        winning_team = @board_presenter.winning_team

        display_msg("Team #{winning_team.name} Won!!!")
      end
    end
  end
end
