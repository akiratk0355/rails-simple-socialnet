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
      
      # anyone should be able to read comments of & comment on published articles
      can [:read, :create], Comment, :article => { :published => true }
      # the article's authors should be able to delete comments as they wish
      # also they can read comments on their own article even in unpublished state
      can [:read, :destroy], Comment, :article => { :user_id => user.id }
      # the commenter should be able to delete own comments as long as the article is published
      can :destroy, Comment, { :user_id => user.id, :article => { :published => true } }
      
      # also note that no one can't modify the existing comments (except admin)
    end
    
  end
end
