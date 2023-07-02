# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stripe_id  :string
#
class Customer < ApplicationRecord
  # Properties
  self.table_name  = 'customers'
  self.primary_key = 'id'

  # Validations
  validates :stripe_id, presence: true

  # Callbacks
  before_validation :create_on_stripe, on: :create

  # Relationships
  has_many :orders

  # Method
  def create_on_stripe
    params = { email: email, name: name }
    response = Stripe::Customer.create(params)
    self.stripe_id = response.id
  end
end
