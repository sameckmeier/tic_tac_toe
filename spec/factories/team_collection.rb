FactoryBot.define do
  factory :team_collection, class: Model::TeamCollection do
    teams { create_list(:team, 2) }

    skip_create
    initialize_with { new(teams) }
  end
end
