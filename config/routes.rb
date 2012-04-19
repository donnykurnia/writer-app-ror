WriterAppRor::Application.routes.draw do

  devise_for :users

  resources :projects
  resources :users

  root :to => 'welcome#index'
end
