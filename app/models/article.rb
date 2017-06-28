class Article < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                      length: { minimum: 5 }
    
    def self.search(search)
      where("title ILIKE ?", "%#{search}%") 
      where("text ILIKE ?", "%#{search}%")
    end
end
