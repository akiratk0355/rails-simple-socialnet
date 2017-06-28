class Article < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    
    before_save :do_publish
    
    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }
    
    # class method for handling search queries
    def self.search(search)
      where("title ILIKE ? OR text ILIKE ?", "%#{search}%", "%#{search}%") 
    end
    
    def do_publish
      if self.published == true
        self.published_at = Time.now
      else
        self.published_at = nil
      end
    end
end
