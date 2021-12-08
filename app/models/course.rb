class Course < ApplicationRecord
  # 課程名稱必填
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0}

  belongs_to :user #optional: true 使用者必須存在，不然會出現錯誤

  has_many :reviews
  has_many :orders
  #透過 through 和 :favor_courses 建立關聯
  has_many :favor_courses
  has_many :users, through: :favor_courses

  def prepare_order(params)
    params = params.merge(amount: self.price, state: 'pending') #取代下面註解的兩行
    order = orders.build(params)
    # order.amount = self.price
    # order.state = 'pending'
    return order
  end

end
