require 'sidekiq/web'
require 'sidetiq/web'

Rails.application.routes.draw do
  # authenticate :user, lambda { |u| u.admin?} do
    mount Sidekiq::Web => '/sidekiq'
  # end

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}

  concern :commentable do
    resources :comments
  end

  concern :votable do
    post :vote_up, on: :member, controller: :votes
    post :vote_down, on: :member, controller: :votes
  end

  resources :questions, concerns: [:commentable, :votable], shallow: true do
    collection do
      get :unanswered
      get :popular
    end
    resources :answers, concerns: [:commentable, :votable] do
      post :accepted, on: :member
      post :unaccepted, on: :member
    end
  end

  resources :users
  resources :attachments, only: :destroy

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
      resources :questions
    end
  end

  get 'tags/:tag', to: 'questions#index', as: :tag
  get 'tags', to: 'questions#tags'

  resources :search, only: :index

  root to: 'questions#index'

end
