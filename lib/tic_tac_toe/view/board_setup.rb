module View
  class BoardSetup < View::Base
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
      type = gets.chomp.to_i

      puts "Please Select Team Name"
      name = gets.chomp

      { type: type, name: name }
    end
  end
end
