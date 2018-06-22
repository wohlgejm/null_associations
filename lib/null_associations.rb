require "null_associations/version"

module NullAssociations
  extend ActiveSupport::Concern

  module ClassMethods
    ASSOCIATIONS = %i(belongs_to has_one)

    ASSOCIATIONS.each do |association|
      define_method(association) do |attribute, scope = nil, **options|
        null_object = options.delete(:null_object)
        if null_object
          define_method(attribute.to_s) do |*args|
            super(args) || null_object.new
          end
        end
        super(attribute, scope, options)
      end
    end
  end
end

ActiveRecord::Base.send :include, NullAssociations
