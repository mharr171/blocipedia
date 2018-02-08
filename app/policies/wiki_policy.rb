class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  # def admin_list?
  #   user.admin?
  # end

  # def index?
  #   true
  # end
  #
  # def show?
  #   true
  # end
  #
  # def create?
  #   user.present?
  # end
  #
  # def new?
  #   create?
  # end
  #
  # def update?
  #   user.present?
  # end
  #
  # def edit?
  #   update?
  # end
  #
  # def destroy?
  #   ( user.present? && user.admin? )
  # end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.nil?  #NECESSARY
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private == false
            wikis << wiki
          end
        end

      elsif user.role.name == 'admin'
        wikis = scope.all # if admin, show all wikis

      elsif user.role.name == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          collabs_with = false
          wiki.collaborators.each do |collab|
            collabs_with = true if collab.user == @user
          end
          if wiki.private == false || wiki.user == user || collabs_with
            wikis << wiki # if premium -> show public, own private, and collaborating wikis
          end
        end

      else # standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          collabs_with = false
          wiki.collaborators.each do |collab|
            collabs_with = true if collab.user == @user
          end
          if wiki.private == false || collabs_with
            wikis << wiki #if standard -> public and collaborating wikis
          end
        end
      end
      wikis # return new array
    end
  end
end
