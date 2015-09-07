PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:delete]    #only: [:new, :create, :edit, :update, :show]
  resources :categories, except: [:delete]
end
