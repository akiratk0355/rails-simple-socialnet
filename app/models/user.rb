USER_ROLES = ['user', 'admin']

class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :role, :inclusion => USER_ROLES
  
  def can_admin?
    if role == "admin"
      true
    else
      false
    end
  end
end
