FactoryBot.define do
  factory :tile_collection, class: Model::TileCollection do
    dimensions { 3 }
    tiles { create_list(:tile, dimensions ** 2) }

    skip_create
    initialize_with { new(tiles, dimensions) }
  end
end
