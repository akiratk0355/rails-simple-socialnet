class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :tag
      t.string :name
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
