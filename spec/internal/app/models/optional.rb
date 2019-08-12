# frozen_string_literal: true

class Optional < ActiveRecord::Base
  has_one :account, optional: false, null_object: NullAccount
end
