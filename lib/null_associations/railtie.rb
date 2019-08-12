# frozen_string_literal: true

module NullAssociations
  class Railtie < Rails::Railtie
    initializer 'null_associations.configure_rails_initialization' do
      ActiveRecord::Base.class_eval do
        extend NullAssociations::ClassMethods
      end
    end
  end

  module ClassMethods
    ASSOCIATIONS = %i[belongs_to has_one].freeze

    ASSOCIATIONS.each do |association|
      define_method(association) do |attribute, scope = nil, **options|
        Options.new(options).validate!
        null_object = options.delete(:null_object)
        if null_object
          define_method(attribute.to_s) do
            super() || null_object.new
          end
        end
        super(attribute, scope, options)
      end
    end
  end

  class Options < OpenStruct
    ConfigError = ArgumentError.new(
      'belongs_to_required_by_default is enabled in your config.'\
      ' This must be disabled to use null objects.'
    )
    RequiredError = ArgumentError.new(
      'A null object cannot be defined when required is true.'
    )
    OptionalError = ArgumentError.new('A null object cannot be defined when optional is false.')

    def initialize(**options)
      super
      validate!
    end

    def validate!
      raise OptionalError if optional_with_null_object?
      raise RequiredError if required_with_null_object?
      raise ConfigError if config_with_null_object?
    end

    private

    def config_with_null_object?
      binding.pry
      null_object && Rails.application.config.active_record.belongs_to_required_by_default
    end

    def required_with_null_object?
      null_object && required == true
    end

    def optional_with_null_object?
      null_object && optional == false
    end
  end
end
