# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :user, Types::User, null: true do
      description "A user"
      argument :auth_id, String, required: true
    end

    def user(auth_id:)
      ::User.find_by(auth_id: auth_id)
    end
  end
end
