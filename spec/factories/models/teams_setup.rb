FactoryBot.define do
  factory :teams_setup, class: Model::TeamsSetup do
    team_klass { Model::Team }
    piece_klass { Model::Piece }
    move_klass { Model::Move }
    move_strategy_klass { Model::MoveStrategy }

    skip_create
    initialize_with do 
      new(
        team_klass: team_klass,
        piece_klass: piece_klass,
        move_klass: move_klass,
        move_strategy_klass: move_strategy_klass
      )
    end
  end
end
