# frozen_string_literal: true

class Required < ActiveRecord::Base
  has_one :account, required: true, null_object: NullAccount
end
