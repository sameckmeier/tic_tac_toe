FactoryBot.define do
  factory :board_view, class: View::Board do
    table_klass { Terminal::Table }
    board_presenter { Presenter::Board }

    skip_create
    initialize_with { new(board_presenter, table_klass) }
  end
end
