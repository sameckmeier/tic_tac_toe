module Presenter
  class SelectTeam
    def initialize(board_setup, team_setup)
      @board_setup = board_setup
      @team_setup = team_setup
    end

    def invalid_team_selection?(type)
      !@team_setup.valid_team_type?(type)
    end

    def team_types
      @team_setup.team_types
    end

    def set_teams(teams_args)
      teams = @team_setup.create_teams(teams_args)
      @board_setup.teams = teams
    end
  end
end
