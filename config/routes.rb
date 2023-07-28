Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get 'date=:date', action: :show_by_date, as: :show_by_date
        end
      end
    end
  end
end
