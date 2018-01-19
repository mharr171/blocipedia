class UserPolicy < ApplicationPolicy
  attr_reader :user, :other_user

  def initialize(user, other_user)
    @user = user
    @other_user = other_user
  end

  def verify_standard
    if user.present?
      user.role.name == 'standard'
    else
      false
    end
  end

  def verify_premium
    if user.present?
      user.role.name == 'premium'
    else
      false
    end
  end

  def verify_admin
    if user.present?
      user.role.name == 'admin'
    else
      false
    end
  end

  def standard?
    verify_standard
  end

  def premium?
    verify_premium
  end

  def admin?
    verify_admin
  end

  def index?
    verify_admin
  end

  def show?
    verify_admin
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    ( user.present? && user.admin? )
  end

  def make_self_standard?
    true
  end

  def make_self_premium?
    true
  end

  def make_self_admin?
    true
  end

  def make_other_standard?
    verify_admin
  end

  def make_other_premium?
    verify_admin
  end

  def make_other_admin?
    verify_admin
  end
  # def scope
  #   # Pundit.policy_scope!(user, record.class)
  #   Pundit.policy_scope!(user, wiki.class)
  # end

  # class Scope
  #   attr_reader :user, :scope
  #
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     scope
  #   end
  # end
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # def resolve
    #   wikis = []
    #   if user.nil?  #NECESSARY
    #     all_wikis = scope.all
    #     wikis = []
    #     all_wikis.each do |wiki|
    #       if !wiki.private?
    #         wikis << wiki
    #       end
    #     end
    #
    #   elsif user.role == 'admin'
    #     wikis = scope.all # if admin, show all wikis
    #
    #   elsif user.role == 'premium'
    #     all_wikis = scope.all
    #     all_wikis.each do |wiki|
    #       if !wiki.private? || wiki.user == user || wiki.collaborating_users.include?(user)
    #         wikis << wiki # if premium -> show public, own private, and collaborating wikis
    #       end
    #     end
    #
    #   else # standard user
    #     all_wikis = scope.all
    #     wikis = []
    #     all_wikis.each do |wiki|
    #       if !wiki.private? || wiki.collaborating_users.include?(user)
    #         wikis << wiki #if standard -> public and collaborating wikis
    #       end
    #     end
    #   end
    #   wikis # return new array
    # end
  end
end
