class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :kana
      t.string :email
      t.text :address

      t.timestamps null: false
    end
  end
end
