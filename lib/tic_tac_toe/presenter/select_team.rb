module Presenter
  class SelectTeam
    def initialize(board_setup, teams_setup)
      @board_setup = board_setup
      @teams_setup = teams_setup
    end

    def invalid_team_selection?(type)
      !@teams_setup.valid_team_type?(type)
    end

    def team_types
      @teams_setup.team_types
    end

    def set_teams(teams_args)
      teams = @teams_setup.create_teams(teams_args)
      @board_setup.teams = teams
    end
  end
end
