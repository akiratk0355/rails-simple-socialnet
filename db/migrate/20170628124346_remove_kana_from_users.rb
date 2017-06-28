class RemoveKanaFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :kana
  end
end
