module View
  class SelectTeam < View::Base
    SELECT_TEAM_TYPE_MESSAGE = 'Please Select Team Type by Entering Number Next to Type'.freeze
    SELECT_TEAM_NAME_MESSAGE = 'Please Select Team Name'.freeze

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
      display_msg(SELECT_TEAM_TYPE_MESSAGE)

      team_types.each { |k, v| display_msg("#{v}: #{k}") }

      type = @terminal_util.get_integer_input

      raise InvalidSelection, 'Invalid Team Selection :(' if @select_team_presenter.invalid_team_selection?(type)

      display_msg(SELECT_TEAM_NAME_MESSAGE)

      name = @terminal_util.get_input

      { type: type, name: name }
    end
  end
end
