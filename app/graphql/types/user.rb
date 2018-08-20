# frozen_string_literal: true

module Types
  class User < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :auth_id, String, null: true
    field :subscribed, Boolean, null: true
    field :admin, Boolean, null: false
    field :created_at, String, null: false
  end
end
