module Model
  class MoveStrategy
    EvaluatedBoard = Struct.new(:game_tree, :rating)

    def select_move(game_tree)
      @team = game_tree.current_team
      evaluated_game_tree = min_max(game_tree, 9, true, -Float::INFINITY, Float::INFINITY)

      evaluated_game_tree.game_tree.previous_move
    end

    private

    def min_max(game_tree, cut_off, maximizing, alpha, beta)
      return evaluated_game_tree(game_tree) if cut_off == 0 || game_tree.complete?

      cut_off -= 1

      if maximizing
        max(game_tree.next_game_trees, cut_off, alpha, beta)
      else
        min(game_tree.next_game_trees, cut_off, alpha, beta)
      end
    end

    def max(game_trees, cut_off, alpha, beta)
      curr_eval_game_tree = nil

      game_trees.each do |game_tree|
        eval_game_tree = min_max(game_tree, cut_off, false, alpha, beta)

        eval_game_tree.game_tree = game_tree

        alpha = eval_game_tree.rating if eval_game_tree.rating > alpha

        curr_eval_game_tree = eval_game_tree if
          curr_eval_game_tree.nil? || eval_game_tree.rating > curr_eval_game_tree.rating

        break if beta <= alpha
      end

      curr_eval_game_tree
    end

    def min(game_trees, cut_off, alpha, beta)
      curr_eval_game_tree = nil

      game_trees.each do |game_tree|
        eval_game_tree = min_max(game_tree, cut_off, true, alpha, beta)

        eval_game_tree.game_tree = game_tree

        beta = eval_game_tree.rating if eval_game_tree.rating < beta

        curr_eval_game_tree = eval_game_tree if
          curr_eval_game_tree.nil? || eval_game_tree.rating < curr_eval_game_tree.rating

        break if beta <= alpha
      end

      curr_eval_game_tree
    end

    def evaluated_game_tree(game_tree)
      EvaluatedBoard.new(game_tree, game_tree.rating(@team))
    end
  end
end
