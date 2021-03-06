Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :micro_posts, only: [:index, :show, :create, :update, :destroy]
      resources :follow_relationships, only: [:create, :destroy]

      resources :authentication, only: [] do
        collection do
          post :authenticate
        end
      end
    end
  end
end
