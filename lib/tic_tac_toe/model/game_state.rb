module Model
  class GameState
    def winner(board)
      tile_collection = board.tile_collection

      rows(tile_collection) || cols(tile_collection) || diags(tile_collection)
    end

    def rating(board, team)
      winner = winner(board)

      return 0 unless winner

      winner.name == team.name ? 1 : -1
    end

    private

    def current_team?(current_team, team)
      (team && current_team) && team.name == current_team.name
    end

    def team(row_i, col_i, tile_collection)
      tile = tile_collection.find_tile(row_i, col_i)

      tile.team
    end

    def rows(tile_collection)
      dims = tile_collection.dimensions

      (1..dims).each do |row_i|
        current_team = team(row_i, 1, tile_collection)

        (2..dims).each do |col_i|
          team = team(row_i, col_i, tile_collection)

          if !current_team?(current_team, team)
            current_team = nil
            break 
          end
        end

        return current_team if current_team
      end

      nil
    end

    def cols(tile_collection)
      dims = tile_collection.dimensions

      (1..dims).each do |col_i|
        current_team = team(1, col_i, tile_collection)

        (2..dims).each do |row_i|
          team = team(row_i, col_i, tile_collection)

          if !current_team?(current_team, team)
            current_team = nil
            break 
          end
        end

        return current_team if current_team
      end

      nil
    end

    def left_diag(tile_collection)
      current_team = team(1, 1, tile_collection)
      dims = tile_collection.dimensions

      (2..dims).each do |i|
        team = team(i, i, tile_collection)

        if !current_team?(current_team, team)
          current_team = nil
          break 
        end
      end

      current_team
    end

    def right_diag(tile_collection)
      dims = tile_collection.dimensions
      col_i = dims
      current_team = team(1, col_i, tile_collection)

      (2..dims).each do |row_i|
        col_i -= 1

        team = team(row_i, col_i, tile_collection)

        if !current_team?(current_team, team)
          current_team = nil
          break 
        end
      end

      current_team
    end

    def diags(tile_collection)
      team = left_diag(tile_collection)

      return team if team

      right_diag(tile_collection)
    end
  end
end
