class AddUserIdToCourse < ActiveRecord::Migration[6.1]
  def change
    # https://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index
    # 會在 courses table 建立一個 user_id
    add_reference :courses, :user, index: true
  end
end
