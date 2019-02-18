FactoryBot.define do
  factory :piece, class: Model::Piece do
    name { "Test #{rand(10000)}" }
    move_factory

    skip_create
    initialize_with { new(name, move_factory) }
  end
end
