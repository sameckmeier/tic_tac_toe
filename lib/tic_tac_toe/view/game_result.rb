module View
  class GameResult < View::Base
    def render
      if @controller.draw?
        puts "Draw!"
      elsif @controller.winner?
        winning_team = @controller.winning_team
        puts "Team #{winning_team.name} Won!!!"
      end
    end
  end
end
