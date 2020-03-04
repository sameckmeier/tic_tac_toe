# This class uses the MinMax algorithm with alpha/beta pruning
# This algorithim reflects the process of a player selecting moves
# That maximize their chances of winning, while another player
# Selects moves to minimize the other player's chances of winning.
# MinMax traverses a GameTree in a DFS manner and at each level promotes
# The highest or lowest GameTree leaf rating, relative to adjacent GameTrees,
# Depending on whether MinMax is executing in a maximizing or minimizing context.
# Alpha/beta pruning optimizes this algorithm by preventing redundant branch traversals.
# Once beta is <= to alpha at any level, MinMax will stop traversing adjacent GameTrees
# And promote the most optimial GameTree at that level.
# Since GameTree#next_game_trees is implemented optimally by filtering out equivalent GameTrees, it
# Improves the performance of MinMax.
# An additional optimization would be to sort GameTrees by their ratings in ascending order.
# This would allow MinMax to establish the final beta GameTree rating much quicker, and prune more branches
# Due to the ascending ordering of the GameTrees.
# MinMax's worst case runtime is O(n!)
# For more details: https://www.geeksforgeeks.org/minimax-algorithm-in-game-theory-set-4-alpha-beta-pruning/

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
      return evaluated_game_tree(game_tree) if cut_off.zero? || game_tree.complete?

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
