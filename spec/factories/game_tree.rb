FactoryBot.define do
  factory :game_tree, class: Model::GameTree do
    board
    move_factory

    skip_create
    initialize_with do
      new(board:        board,
          move_factory: move_factory)
    end
  end
end
