# frozen_string_literal: true

class Account < ActiveRecord::Base
  belongs_to :supplier, null_object: NullSupplier

  def null?
    false
  end
end
