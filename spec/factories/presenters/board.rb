FactoryBot.define do
  factory :board_presenter, class: Presenter::Board do
    board
    game_tree_klass { Model::GameTree }

    skip_create
    initialize_with do
      new(board, game_tree_klass)
    end
  end
end
