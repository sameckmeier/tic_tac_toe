module View
  class GameResult < View::Base
    def render
      if @presenter.draw?
        puts "Draw!"
      elsif @presenter.winner?
        winning_team = @presenter.winning_team
        puts "Team #{winning_team.name} Won!!!"
      end
    end
  end
end
