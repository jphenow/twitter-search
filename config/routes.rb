TwitterSearch::Application.routes.draw do
  resource :search, only: [:create, :show]

  root to: "searches#show"
end
