class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  # def admin_list?
  #   user.admin?
  # end

  def index?
    true
  end

  def show?
    true
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
