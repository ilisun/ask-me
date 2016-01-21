class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: 'No Name'
    add_column :users, :about, :text, default: 'I like this service...'
  end
end
