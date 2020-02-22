FactoryBot.define do
  factory :select_team_presenter, class: Presenter::SelectTeam do
    board_setup
    teams_setup

    skip_create
    initialize_with do
      new(board_setup, teams_setup)
    end
  end
end
