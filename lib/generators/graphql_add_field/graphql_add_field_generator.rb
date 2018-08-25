class GraphqlAddFieldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  def configure_add_graphql_field
    line = "field :id, ID, null: false"
    gsub_file "app/graphql/types/#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n" + attributes_for_grahql.map do | attribute |
        "    field :#{attribute.name}, #{attribute.type.capitalize}, null: true"
      end.join("\n")
    end
  end

  def configure_add_graphql_field_to_create_mutation_argument
    line = "null true\n"
    gsub_file "app/graphql/mutations/create_#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n" + attributes_for_grahql.map do | attribute |
        "    argument :#{attribute.name}, #{attribute.type.capitalize}, required: false"
      end.join("\n")
    end
  end

  def configure_add_graphql_field_to_create_mutation_resolve
    line = "def resolve("
    gsub_file "app/graphql/mutations/create_#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}" + attributes_for_grahql.map do | attribute |
        "#{attribute.name}:"
      end.join(", ") + ", "
    end
  end

  def configure_add_graphql_field_to_create_mutation_new
    line = "#{class_name}.new("
    gsub_file "app/graphql/mutations/create_#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n" + attributes_for_grahql.map do | attribute |
        "        #{attribute.name}: #{attribute.name},"
      end.join("\n")
    end
  end

  def configure_add_graphql_field_to_update_mutation_argument
    line = "argument :id, ID, required: true"
    gsub_file "app/graphql/mutations/update_#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n" + attributes_for_grahql.map do | attribute |
        "    argument :#{attribute.name}, #{attribute.type.capitalize}, required: true"
      end.join("\n")
    end
  end

  def configure_add_graphql_field_to_update_mutation_resolve
    line = "def resolve(id:, "
    gsub_file "app/graphql/mutations/update_#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}" + attributes_for_grahql.map do | attribute |
        "#{attribute.name}:"
      end.join(", ") + ", "
    end
  end

  def configure_add_graphql_field_to_update_mutation_update_attributes
    line = "update_attributes("
    gsub_file "app/graphql/mutations/update_#{class_name.underscore}.rb", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}" + attributes_for_grahql.map do | attribute |
        "#{attribute.name}: #{attribute.name}"
      end.join(", ") + ", "
    end
  end

  def configure_add_graphql_field_to_create_mutation_component_variables
    line = "mutation Create#{class_name}("
    gsub_file "app/javascript/graphql/mutations/Create#{class_name}Mutation.js", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}" + attributes_for_grahql.map do | attribute |
        "$#{attribute.name.camelcase(:lower)}: #{attribute.type.capitalize}"
      end.join(", ") + ", "
    end
  end

  def configure_add_graphql_field_to_create_mutation_component_arguments
    line = "    create#{class_name}("
    gsub_file "app/javascript/graphql/mutations/Create#{class_name}Mutation.js", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}" + attributes_for_grahql.map do | attribute |
        "#{attribute.name.camelcase(:lower)}: $#{attribute.name.camelcase(:lower)}"
      end.join(", ") + ", "
    end
  end

  def configure_add_graphql_field_to_create_mutation_component_return
    line = "#{class_name.camelcase(:lower)} {"
    gsub_file "app/javascript/graphql/mutations/Create#{class_name}Mutation.js", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n" + attributes_for_grahql.map do | attribute |
        "        #{attribute.name.camelcase(:lower)}"
      end.join("\n")
    end
  end

  def configure_add_graphql_field_to_update_mutation_component_variables
    line = "$id: ID!"
    gsub_file "app/javascript/graphql/mutations/Update#{class_name}Mutation.js", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}, " + attributes_for_grahql.map do | attribute |
        "$#{attribute.name.camelcase(:lower)}: #{attribute.type.capitalize}!"
      end.join(", ")
    end
  end

  def configure_add_graphql_field_to_update_mutation_component_arguments
    line = "id: $id"
    gsub_file "app/javascript/graphql/mutations/Update#{class_name}Mutation.js", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}, " + attributes_for_grahql.map do | attribute |
        "#{attribute.name.camelcase(:lower)}: $#{attribute.name.camelcase(:lower)}"
      end.join(", ")
    end
  end

  def configure_add_graphql_field_to_update_mutation_component_return
    line = "#{class_name.camelcase(:lower)} {"
    gsub_file "app/javascript/graphql/mutations/Update#{class_name}Mutation.js", /(#{Regexp.escape(line)})/mi do |match|
      "#{match}\n" + attributes_for_grahql.map do | attribute |
        "        #{attribute.name.camelcase(:lower)}"
      end.join("\n")
    end
  end

  private

    def attributes_for_grahql
      attributes.map do |attribute|
        case attribute.type
        when :integer
          attribute.type = :int
        end
        attribute
      end
    end
end
