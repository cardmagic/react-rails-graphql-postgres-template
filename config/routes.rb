# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'
  get '*path', to: 'application#index'
  post '/graphql', to: 'graphql#execute'
end
