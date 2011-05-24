Bookcamp::Application.routes.draw do
  root :to => 'book_lists#index'
  resources :book_lists, :path => 'listas' do
    get :show_all, :on => :collection, :path => 'camping'
  end

  resources :books, :path => 'libros'

  match "/auth/:provider/callback" => "sessions#create"
  match "/salir" => "sessions#destroy", :as => :signout
end
