module View
  class BoardSetup < View::Terminal
    def render
      select_teams
    end

    private

    def select_teams
      teams = (1..2).map { |_| select_team(@controller.team_types) }
      @controller.set_teams(teams)
    end

    def select_team(team_types)
      puts "Please Select Team Type by Entering Number Next to Type"
      team_types.each { |k, v| puts "#{v}: #{k}" }
      type = @terminal_util.get_integer_input

      puts "Please Select Team Name"
      name = @terminal_util.get_input

      { type: type, name: name }
    end
  end
end
