# frozen_string_literal: true

module API
  module V1
    class OrdersController < ApplicationController
      def create
        @order = Order.new(
          order_params.merge(
            amount_cents: rand(100_000_00..300_000_00),
            payment_method: 'credit_card'
          )
        )

        if @order.save
          render json: {
            order: @order,
            payment: @order.payment
          }, status: :created
        else
          render json: {
            errors: @order.errors
          }, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:data)
          .permit(:customer_id, :credit_card_number, :credit_card_exp_month,
            :credit_card_exp_year, :credit_card_cvv)
      end
    end
  end
end