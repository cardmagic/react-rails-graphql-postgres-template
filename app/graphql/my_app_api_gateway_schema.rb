# frozen_string_literal: true

class MyAppApiGatewaySchema < GraphQL::Schema
  use ApolloTracing.new
  use BatchLoader::GraphQL
  mutation(Types::MutationType)
  query(Types::QueryType)

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    nil
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    message = exception.record.errors.full_messages.join("\n")
    GraphQL::ExecutionError.new(message)
  end

  rescue_from StandardError do |_exception|
    message = "Please try to execute the query for this field later"
    GraphQL::ExecutionError.new(message)
  end
end
