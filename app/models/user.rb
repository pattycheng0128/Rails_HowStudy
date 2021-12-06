require 'digest'

class User < ApplicationRecord

  #要在 course.rb 加 belongs_to 才有關連
  #has_one :course 只會撈到一筆資料
  has_many :courses #會撈到多筆資料

  #名字沒取好?
  #透過 through 和 :favor_courses 建立關聯
  has_many :favor_courses
  has_many :favorite_courses, through: :favor_courses, source: :course
 
  # 寫在 Model 裡面可以重複使用
  # validates(:username, {presence: ture})
  # validates_presence_of 是較舊的寫法
  validates :username, presence: true

  # 驗證 email 並且是唯一的
  validates :email, presence: true, uniqueness: true

  # 驗證 email 的格式是否正確(regular expression)
  # validates :email, format: { with: /\A[a-zA-Z]+\z/,
  #   message: "only allows letters" }

  # https://rails.ruby.tw/active_record_callbacks.html
  before_create :encrypt_password

  def self.login(user_info)
    email = user_info[:email]
    password = user_info[:password]
    salted_password = "xy#{password.reverse}hellohey"
    encryted_password = Digest::SHA1.hexdigest(salted_password)

    self.find_by(email: email, password: encryted_password)
  end
  
  private
  def encrypt_password
    # setter
    # self 也是代表自己，和類別方法無關
    #password = Digest::SHA1.hexdigest(self.password) #不會加密，會直接輸出密碼
    # self.password = Digest::SHA1.hexdigest(password)
    salted_password = "xy#{password.reverse}hellohey"
    self.password = Digest::SHA1.hexdigest(salted_password)
  end

end
