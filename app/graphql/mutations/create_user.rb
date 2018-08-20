# frozen_string_literal: true

module Mutations
  class CreateUser < GraphQL::Schema::Mutation
    null true

    argument :name, String, required: true
    argument :email, String, required: true
    argument :auth_id, String, required: true

    field :user, Types::User, null: true
    field :errors, [String], null: false

    def resolve(name:, email:, auth_id:)
      if (user = User.find_by(email: email))
        user.auth_id = auth_id
        user.save
        {
          user: user,
          errors: ["User already exists"]
        }
      else
        user = User.new(
          name: name,
          email: email
        )

        if user.save
          return {
            user: user,
            errors: []
          }
        else
          return {
            user: nil,
            errors: user.errors.full_messages
          }
        end
      end
    end
  end
end
