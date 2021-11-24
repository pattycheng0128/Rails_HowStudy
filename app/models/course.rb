class Course < ApplicationRecord
  # 課程名稱必填
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0}

  belongs_to :user #optional: true 使用者必須存在，不然會出現錯誤

end
