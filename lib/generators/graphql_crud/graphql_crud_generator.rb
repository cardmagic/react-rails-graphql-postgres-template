# frozen_string_literal: true

class GraphqlCrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  def generate_type_file
    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    template "model_type.template", "app/graphql/types/#{file_name}.rb"
  end

  def configure_graphql_list
    line = "class QueryType < Types::BaseObject"
    gsub_file "app/graphql/types/query_type.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n    field :#{class_name.underscore.pluralize}, [Types::#{class_name}], null: true do\n      description \"A list of #{class_name.underscore.pluralize}\"\n    end\n    def #{class_name.downcase.pluralize}\n      ::#{class_name}.all\n    end\n\n    field :#{class_name.downcase}, Types::#{class_name}, null: true do\n      description \"A #{class_name.downcase}\"\n      argument :id, ID, required: true\n    end\n    def #{class_name.downcase}(id:)\n      ::#{class_name}.find(id: id)\n    end\n"
    end

    line = "class MutationType < Types::BaseObject"
    gsub_file "app/graphql/types/mutation_type.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n    field :create#{class_name}, mutation: Mutations::Create#{class_name}\n    field :update#{class_name}, mutation: Mutations::Update#{class_name}\n    field :delete#{class_name}, mutation: Mutations::Delete#{class_name}"
    end
  end

  def generate_create_mutation_server
    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    template "create_mutation_server.template", "app/graphql/mutations/create_#{file_name}.rb"
  end

  def generate_create_mutation_client
    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    template "create_mutation_client.template", "app/javascript/graphql/mutations/create#{class_name}.js"
  end

  def generate_update_mutation_server
    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    template "update_mutation_server.template", "app/graphql/mutations/update_#{file_name}.rb"
  end

  def generate_update_mutation_client
    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    template "update_mutation_client.template", "app/javascript/graphql/mutations/update#{class_name}.js"
  end

  def generate_delete_mutation_server
    template "delete_mutation_server.template", "app/graphql/mutations/delete_#{file_name}.rb"
  end

  def generate_delete_mutation_client
    template "delete_mutation_client.template", "app/javascript/graphql/mutations/delete#{class_name}.js"
  end

  private

    def attributes_with_index
      attributes.select { |a| !a.reference? && a.has_index? }
    end
end
