WayweworkIt::Application.routes.draw do
  match 'author/:id' =>'posts#by_author', :as => :posts_by_author
  match 'month/:year/:month' =>'posts#by_month', :as => :posts_by_month
  match '/atom' => 'posts#index', :as => :atom_feed, :format => :atom
  
  resources :feeds

  root :to => 'posts#index'
end
