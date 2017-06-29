class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    # See the CanCanCan's wiki for syntax details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    
    user ||= User.new # guest user (not logged in)
    
    # admin user can operate anything
    if user.can_admin?
      can :manage, :all
    else
      can :manage, Article, :user_id => user.id
      # anyone should be able to read published articles
      can :read, Article, :published => true
      # anyone should be able to create new articles
      can :create, Article
      
      can :manage, Comment, :user_id => user.id
      # anyone should be able to read comments of & comment on published articles
      can [:read, :create], Comment, :article => { :published => true }
      # the article's author should be able to delete comments as they wish
      can :destroy, Comment, :article => { :user_id => user.id }
    end
    
  end
end
