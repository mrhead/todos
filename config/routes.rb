Rails.application.routes.draw do
  root to: "todos#index"

  resources :todos, only: [:index, :create, :show, :edit, :update, :destroy] do
    post :toggle, on: :member
  end
end
