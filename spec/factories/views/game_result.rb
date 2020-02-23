FactoryBot.define do
  factory :game_result_view, class: View::GameResult do
    board_presenter { Presenter::Board }

    skip_create
    initialize_with { new(board_presenter) }
  end
end
