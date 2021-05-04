class AddSomeFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    # column
    add_column :users, :username, :string
    add_column :users, :bio, :string
    add_column :users, :website, :string
    add_column :users, :avatar, :string
    add_column :users, :slug, :string

    # index
    add_index :users, :slug, unique: true
  end
end
