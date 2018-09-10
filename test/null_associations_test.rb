require 'test_helper'

class NullAssociationsTest < Minitest::Test
  def test_non_null_object_belongs_to
    supplier = Supplier.create!(name: 'test')
    account = Account.create!(account_number: 1, supplier: supplier)
    assert account.supplier_id == supplier.id
    assert account.supplier.null? == false
  end

  def test_null_object_belongs_to
    account = Account.create!(account_number: 1, supplier: nil)
    assert account.supplier.is_a?(NullSupplier) == true
    assert account.supplier.null? == true
  end

  def test_non_null_object_has_one
    supplier = Supplier.create!(name: 'test')
    account = Account.create!(account_number: 1, supplier: supplier)
    assert supplier.account.id == account.id
    assert supplier.account.null? == false
  end

  def test_null_object_has_one
    supplier = Supplier.create!(name: 'test')
    assert supplier.account.is_a?(NullAccount) == true
    assert supplier.account.null? == true
  end

  def test_optional_false
    assert_raises ArgumentError do
      Account.class_eval do
        belongs_to :supplier, optional: false, null_object: NullSupplier
      end
    end
  end

  def test_required_true
    assert_raises ArgumentError do
      Account.class_eval do
        belongs_to :supplier, required: true, null_object: NullSupplier
      end
    end
  end
end
