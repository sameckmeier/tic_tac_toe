FactoryBot.define do
  factory :select_move_view, class: View::SelectMove do
    board_presenter { Presenter::Board }
    terminal_util { Utils::Terminal }

    skip_create
    initialize_with { new(board_presenter, terminal_util) }
  end
end
