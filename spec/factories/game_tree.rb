FactoryBot.define do
  factory :game_tree, class: Model::GameTree do
    board

    skip_create
    initialize_with do
      new(board)
    end
  end
end
