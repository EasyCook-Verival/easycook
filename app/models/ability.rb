# Ability model for CanCan
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :type, to: :read
    alias_action :tags, to: :read
    alias_action :post_type, to: :create

    if user.role? 'admin'
      can :manage, :all
    elsif user.role? 'cook'
      can [:read, :create], [Ingredient, Recipe]
      can [:update, :destroy], Recipe, user_id: user.id
    else # guest user (not logged in)
      can :read, :all
    end
  end
end
