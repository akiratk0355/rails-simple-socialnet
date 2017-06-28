class Article < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    
    def self.search(search)
      where("title ILIKE ? OR text ILIKE ?", "%#{search}%", "%#{search}%") 
    end
end
