Rails.application.routes.draw do
  root "root#index"

  resources :procon_bypass_man_commands, only: [:create]
  resources :procon_bypass_man_hosts, only: [:index, :new, :create, :edit, :update, :destroy]
end
