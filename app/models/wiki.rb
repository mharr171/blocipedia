class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def possible_collaborators
    User.all.reject { |u| u.id == user.id || users.include?(u) }
  end
end
