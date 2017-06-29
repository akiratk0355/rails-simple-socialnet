class DropOrganizations < ActiveRecord::Migration

  def up
    drop_table :organizations
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end

end
