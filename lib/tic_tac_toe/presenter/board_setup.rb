module Presenter
  class BoardSetup
    def initialize(board_setup, view)
      @view = view
      @board_setup = board_setup
    end

    def run
      @view.render(presenter:  self,
                   team_types: @board_setup.team_types)
    end

    def set_teams(teams)
      @board_setup.update(teams: teams)
    end
  end
end
