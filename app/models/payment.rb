# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer          not null
#  stripe_id  :string
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  order_id  (order_id => orders.id)
#
class Payment < ApplicationRecord
  # Properties
  self.table_name  = 'payments'
  self.primary_key = 'id'

  # Accessors
  attr_accessor :credit_card_number, :credit_card_exp_month,
                :credit_card_exp_year, :credit_card_cvv

  # Callbacks
  before_validation :create_on_stripe

  # Relationships
  belongs_to :order

  # Methods
  def create_on_stripe
    token = get_token
    params = { amount: order.amount_cents, currency: 'usd',  source: token }
    response = Stripe::Charge.create(params)
    self.stripe_id = response.id
  end

  def get_token
    Stripe::Token.create({
      card: {
        number:     credit_card_number,
        exp_month:  credit_card_exp_month,
        exp_year:   credit_card_exp_year,
        cvc:        credit_card_cvv
      }
    })
  end
end
