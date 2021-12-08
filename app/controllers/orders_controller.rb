class OrdersController < ApplicationController

  before_action :authenticate!

  def create
    # render html: params
    # 找到課程內容
    @course = Course.find(params[:course_id])
    # 課程訂單
    # @order = @course.orders.build(clean_params)
    @order = @course.prepare_order(clean_params) # prepare_order寫在 course.rb

    if @order.save
      #刷卡
      gateway = Braintree::Gateway.new(
        environment: :sandbox,
        merchant_id: "snq96mkz2r2py4vm",
        public_key: "4d9c98wws2qnyxvt",
        private_key: "f6eb1b220f883e76c02f123c66050a80",
      )

      result = gateway.transaction.sale(
        amount: @order.amount,
        payment_method_nonce: params[:nonce] #view 設定的隱藏欄位 nonce
      )

      if result.success?
        redirect_to root_path, notice: '課程購買成功'
      else
        redirect_to root_path, notice: '付款過程發生問題'
      end
    end
  end

  private
  def clean_params
    params.require(:order).permit(:recipient, :address).merge(user: current_user)
  end

end
