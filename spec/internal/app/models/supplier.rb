# frozen_string_literal: true

class Supplier < ActiveRecord::Base
  has_one :account, null_object: NullAccount

  def null?
    false
  end
end
