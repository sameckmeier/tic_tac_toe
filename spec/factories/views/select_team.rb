FactoryBot.define do
  factory :select_team_view, class: View::SelectTeam do
    select_team_presenter { Presenter::SelectTeam }
    terminal_util { Utils::Terminal }

    skip_create
    initialize_with { new(select_team_presenter, terminal_util) }
  end
end
