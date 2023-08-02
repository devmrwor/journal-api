Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post '/login', to: 'users/sessions#create'
    delete '/logout', to: 'users/sessions#destroy'
  end
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get 'date=:date', action: :show_by_date, as: :show_by_date
          get 'label=:label', action: :index_by_label, as: :index_by_label
        end
      end
    end
  end
end
