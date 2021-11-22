class AddUserIdToCourse < ActiveRecord::Migration[6.1]
  def change
    # https://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index
    add_reference :courses, :user, index: true
  end
end
