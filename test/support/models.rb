ActiveRecord::Schema.define do
  create_table :suppliers do |t|
    t.string :name
    t.timestamps null: true
  end

  create_table :accounts do |t|
    t.integer :supplier_id
    t.string  :account_number
    t.timestamps null: true
  end
end

class NullSupplier
  def null?
    true
  end
end

class NullAccount
  def null?
    true
  end
end

class Supplier < ActiveRecord::Base
  has_one :account, null_object: NullAccount

  def null?
    false
  end
end

class Account < ActiveRecord::Base
  belongs_to :supplier, null_object: NullSupplier

  def null?
    false
  end
end
