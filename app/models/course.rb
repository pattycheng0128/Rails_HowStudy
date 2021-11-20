class Course < ApplicationRecord
  # 課程名稱必填
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0}
end
