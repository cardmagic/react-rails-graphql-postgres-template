# frozen_string_literal: true

class GraphqlModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  def generate_type_file
    attributes.each { |a| a.attr_options.delete(:index) if a.reference? && !a.has_index? } if options[:indexes] == false
    template "model_type.template", "app/graphql/types/#{file_name}.rb"
  end

  def configure_graphql_model
    line = "class QueryType < Types::BaseObject"
    gsub_file "app/graphql/types/query_type.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n    field :#{class_name.downcase.pluralize}, [Types::#{class_name}], null: true do\n      description \"A list of #{class_name.downcase.pluralize}\"\n    end\n\n    def #{class_name.downcase.pluralize}\n      ::#{class_name}.all\n    end\n"
    end
  end

  private

    def attributes_with_index
      attributes.select { |a| !a.reference? && a.has_index? }
    end
end
