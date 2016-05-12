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

end
