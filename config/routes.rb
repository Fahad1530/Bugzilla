Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  get 'home/about'
  # root to: redirect('http://localhost:3000/users/sign_in')
  root to: 'home#index'
#   devise_scope :user do
#   root to: "devise/sessions#new"
# end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
