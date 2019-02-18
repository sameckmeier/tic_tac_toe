module Model
  class GameTreeFactory
    def generate_game_tree(board)
      GameTree.new(board: board, move_factory: Model::MoveFactory.new)
    end
  end
end
