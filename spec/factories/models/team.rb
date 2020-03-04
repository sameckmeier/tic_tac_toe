FactoryBot.define do
  factory :team, class: Model::Team do
    name { "Test #{rand(10_000)}" }
    pieces { create_list(:piece, 1) }

    skip_create
    initialize_with { new(name: name, pieces: pieces) }

    factory :team_with_move_strategy, class: Model::Team do
      move_strategy

      skip_create
      initialize_with { new(name: name, move_strategy: move_strategy, pieces: pieces) }
    end
  end
end
