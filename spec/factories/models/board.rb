FactoryBot.define do
  factory :board, class: Model::Board do
    tile_collection
    team_collection
    game_state

    skip_create
    initialize_with do
      new(tile_collection: tile_collection,
          team_collection: team_collection,
          game_state: game_state)
    end
  end
end
