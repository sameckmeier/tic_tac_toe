FactoryBot.define do
  factory :piece, class: Model::Piece do
    name { "Test #{rand(10_000)}" }

    skip_create
    initialize_with { new(name, Model::Move) }
  end
end
