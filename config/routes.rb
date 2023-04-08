Rails.application.routes.draw do
  root "root#index"

  resources :procon_bypass_man_commands, only: [:create]
end
