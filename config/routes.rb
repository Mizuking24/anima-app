Rails.application.routes.draw do
 devise_for :users
 root to: "homes#top"
 get "/about" => "homes#about"

resources :animes do
 resource :likes, only: [:create, :destroy]
 resources :post_comments, only: [:create, :destroy]
end

resources :users, only: [:index, :show, :edit, :update] do
 get :search, on: :collection
 resources :relationships, only: [:create, :destroy]
 get "followings" => "relationships#followings"
 get "followers" => "relationships#followers"
end

end
