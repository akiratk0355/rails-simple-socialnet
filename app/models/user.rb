class User < ActiveRecord::Base
  has_many :articles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def can_admin?
    if id == 1
      true
    else
      false
    end
  end
end
