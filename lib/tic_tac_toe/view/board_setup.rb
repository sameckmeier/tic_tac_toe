module View
  class BoardSetup
    def render(args)
      select_teams(args[:presenter], args[:team_types])
    end

    private

    def select_teams(presenter, team_types)
      teams = (1..2).map { |_| select_team(team_types) }
      presenter.set_teams(teams)
    end

    def select_team(team_types)
      puts "Please Select Team Type by Entering Number Next to Type"
      team_types.each { |k, v| puts "#{v}: #{k}" }
      type = gets.chomp.to_i

      puts "Please Select Team Name"
      name = gets.chomp

      { type: type, name: name }
    end
  end
end
