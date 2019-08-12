# frozen_string_literal: true

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

  create_table :requireds do |t|
  end

  create_table :optionals do |t|
  end
end
