FactoryBot.define do
  factory :board_setup, class: Model::TeamsSetup do
    board_klass { Model::Board }
    tile_collection_klass { Model::TileCollection }
    team_collection_klass { Model::TeamCollection }
    game_state
    tile_klass { Model::Tile }
    dimensions { 1 }

    skip_create
    initialize_with do 
      new(
        board_klass: board_klass,
        tile_collection_klass: tile_collection_klass,
        team_collection_klass: team_collection_klass,
        game_state: game_state,
        tile_klass: tile_klass,
        dimensions: dimensions
      )
    end
  end
end
