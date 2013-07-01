TwitterSearch::Application.routes.draw do
  resource :search, only: [:create, :show]

  root to: "search#show"
end
