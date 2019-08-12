# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NullAssociations do
  context 'when there is an associated object' do
    it 'is not null' do
      supplier = Supplier.create!(name: 'test')
      account = Account.create!(supplier: supplier, account_number: 1)
      expect(account.supplier).to eq(supplier)
    end
  end

  context 'when the associated object is null' do
    it 'is an instance of the null object' do
      account = Account.create!(account_number: 1)
      expect(account.supplier).to be_an_instance_of(NullSupplier)
    end
  end

  context 'when the association specifies required true' do
    it 'errors' do
      expect { Required.create! }.to raise_error(
        ArgumentError, 'A null object cannot be defined when required is true.'
      )
    end
  end

  context 'when the association specifies optional false' do
    it 'errors' do
      expect { Optional.create! }.to raise_error(
        ArgumentError, 'A null object cannot be defined when optional is false.'
      )
    end
  end

  context 'when application config specifies belongs_to required by default' do
    before do
      binding.pry
    end
    it 'errors' do
      binding.pry
      expect { puts 'blah' }.to raise_error(
        ArgumentError, 'belongs_to_required_by_default is enabled in your config. This must be disabled to use null objects.'
      )
    end
  end
end
