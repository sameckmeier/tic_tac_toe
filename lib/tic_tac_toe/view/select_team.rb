module View
  class SelectTeam < View::Base
    def initialize(select_team_presenter, terminal_util)
      @select_team_presenter = select_team_presenter
      @terminal_util = terminal_util
    end

    def render
      select_teams
    end

    private

    def select_teams
      teams = (1..2).map { |_| select_team(@select_team_presenter.team_types) }

      @select_team_presenter.set_teams(teams)
    end

    def select_team(team_types)
      display_msg("Please Select Team Type by Entering Number Next to Type")

      team_types.each { |k, v| display_msg("#{v}: #{k}") }

      type = @terminal_util.get_integer_input

      raise InvalidSelection, "Invalid Team Selection :(" if @select_team_presenter.invalid_team_selection?(type)

      display_msg("Please Select Team Name")

      name = @terminal_util.get_input

      { type: type, name: name }
    end
  end
end
