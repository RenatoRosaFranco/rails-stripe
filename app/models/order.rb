# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  amount_cents   :integer
#  payment_method :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer          not null
#
# Indexes
#
#  index_orders_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#
class Order < ApplicationRecord
  # Properties
  self.table_name  = 'orders'
  self.primary_key = 'id'

  # Accessors
  attr_accessor :credit_card_number, :credit_card_exp_month,
                :credit_card_exp_year, :credit_card_cvv

  # Enum
  enum payment_method: ['credit_card']

  # Relationships
  has_one :payment
  belongs_to :customer

  # Callbacks
  after_create :create_payment

  # Relationships
  belongs_to :customer

  # Methods
  def create_payment
    params = {
      order_id:              id,
      credit_card_number:    credit_card_number,
      credit_card_exp_month: credit_card_exp_month,
      credit_card_exp_year:  credit_card_exp_year,
      credit_card_cvv:       credit_card_cvv
    }

    Payment.create!(params)
  end
end
