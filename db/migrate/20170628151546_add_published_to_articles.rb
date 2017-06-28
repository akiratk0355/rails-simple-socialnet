class AddPublishedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean, :default => false, null: false
    add_column :articles, :published_at, :datetime
  end
end
