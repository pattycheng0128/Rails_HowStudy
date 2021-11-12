class ApplicationRecord < ActiveRecord::Base
  # 抽象類別 - 在 ruby 沒有，是額外被 Rails 定義出來的
  # 不能用 ApplicationRecord 做 new，但可以透過繼承 ApplicationRecord 的方式來 new 物件，
  # 實際上在專案裡面不會用到抽象類別
  # 即使沒有這行，new 也沒東西
  self.abstract_class = true

  # 印出錯誤
  # debugger

end
