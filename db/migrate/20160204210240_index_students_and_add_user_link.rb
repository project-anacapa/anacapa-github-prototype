class IndexStudentsAndAddUserLink < ActiveRecord::Migration
  def change

    add_column :students, :user_id, :integer, null: true
    add_foreign_key :students, :users, column: :user_id
    
    add_index :students, :email, unique: true
    add_index :students, :studentid, unique: true
  end
end
