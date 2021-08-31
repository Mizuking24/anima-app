Rails.application.routes.draw do
 devise_for :users
 root to: "homes#top"
 get "/about" => "homes#about"

resources :animes do
 resources :post_comments, only: [:create, :destroy]
end

end
