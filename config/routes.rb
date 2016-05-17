Rails.application.routes.draw do
  root "site#index"

  scope "/api", shallow: true do
    resources :languages, only: [:index, :show] do
      resources :klasses, only: [:index, :show] do
        resources :articles, only: [:index, :show]
        resources :meths, only: [:index, :show]
      end
    end
  end

  # ajax routes
  get "/articles/:klass_id/" => "articles#ajax_index", as: "fetch_articles"

  # devise simplified routes
  devise_for :users, path: "",
    path_names: {sign_in: "login", sign_up: "signup"}
    # controllers: { sessions: "users/sessions"}
end
