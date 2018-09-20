class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    undified_user
    return if user.blank?
    case controller_namespace
    when "backend"
      permission_admin if user.admin?
    else
      permission_user user
    end
  end

  def permission_admin
    can :manage, :all
  end

  def permission_user user
    can :read, User, id: user.id
    can :update, User, id: user.id
    can :create, [Comment, Suggest]
    can :update_quantity_in_cart, :cart
    can :manage, :cart
    can :manage, Order
  end

  def undified_user
    can :read, [Category, Product, Comment]
    can :manage, :cart
  end
end
