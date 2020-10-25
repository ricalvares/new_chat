Rails.application.routes.draw do
  root 'landing#index'

  resources :chat_room
  resources :messages, only: [:new, :create]
  get 'landing/index'
end
