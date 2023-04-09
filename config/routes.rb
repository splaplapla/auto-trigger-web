Rails.application.routes.draw do
  root "root#index"

  resource :setting, only: [:update]
  resources :procon_bypass_man_remote_single_commands, only: [:create]

  resources :procon_bypass_man_commands, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :remote_commands, only: [:create], module: :procon_bypass_man_commands
  end

  resources :procon_bypass_man_hosts, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :command_rules, only: [:update, :destroy]

  resources :captured_images, only: [:create]
end
