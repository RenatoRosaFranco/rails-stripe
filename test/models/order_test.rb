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
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
