class User < ApplicationRecord
  # 寫在 Model 裡面可以重複使用
  # validates(:username, {presence: ture})
  validates :username, presence: true
end
